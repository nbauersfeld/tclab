from asyncua import Server,ua,uamethod,Node
from asyncua.server.internal_server import InternalServer
from asyncua.server.user_managers import CertificateUserManager

from typing import List

import asyncio
import os
import numpy as np
from datetime import datetime

from codetiming import Timer

import logging
logging.basicConfig(level=logging.ERROR)

_logger = logging.getLogger(__name__)
_logger.setLevel(logging.DEBUG)
_logger.name = "_server_"
def filter_(record: logging.Filter):
    if isinstance(record.msg,str):
        return True # not record.msg.startswith("asyncua")
    return True
_logger.addFilter(filter_)

class server_(Server):

    def __init__(self, iserver: InternalServer = None, user_manager=None, args=None):
        super().__init__(iserver, user_manager)
        self.args = args
        
    async def secure_(self,user=None):
        if user is None:
            return False
        await CertificateUserManager().add_user(self.args["certificate"],name=user)
        return True
    
    ns = None
    
    async def start_(self,password=None):
        
        _logger.debug('start_')

        with Timer(text="---start time: {:.1f}s"):

            try:

                await self.init()
                
                self.set_endpoint(self.args["url"])
                self.set_server_name(self.args["name"])
                self.set_force_server_timestamp(force_server_timestamp=True)
                
                if (self.args["certificate"] is not None) and (password is not None):
                    self.set_security_policy([
                        ua.SecurityPolicyType.Basic256Sha256_SignAndEncrypt,
                        ua.SecurityPolicyType.Basic256Sha256_Sign
                    ])
                    await self.load_certificate(self.args["certificate"])
                    await self.load_private_key(self.args["private_key"],password=password)
                else:
                    self.set_security_policy([ua.SecurityPolicyType.NoSecurity])

                self.ns = await self.register_namespace(self.args["uri"])
            
            except Exception as e:
                _logger.error(e)
                return False

        return True
    
    async def stop_(self):
        _logger.debug('stop_')
        await self.stop()
            
    @uamethod
    def setup_(parent,v):                
        
        _logger.debug('setup_')

        return (v)
    
    async def load_(self):

        _logger.debug('load_')

        with Timer(text="---load time: {:.1f}s"):

            # data container
            container = await self.nodes.objects.add_object(self.ns,bname="container")
                        
            # variables
            t = await container.add_variable(self.ns,"t",0,varianttype=ua.VariantType.DateTime)
            await t.set_writable()
            u = await container.add_variable(self.ns,"u",0,varianttype=ua.VariantType.Int64)
            await u.set_writable()
            y = await container.add_variable(self.ns,"y",0.0,varianttype=ua.VariantType.Double)
            await y.set_writable()

            a_ = [0,0,0]
            a = await container.add_variable(self.ns,"a",a_,varianttype=ua.VariantType.Int64)
            await a.set_writable()

            _logger.debug(t)
            _logger.debug(u)
            _logger.debug(y)
   
            # method
            v = ua.Argument()
            v.Name = "v"
            v.DataType = ua.NodeId(ua.ObjectIds.Int32)
            v.ValueRank = -1
            v.ArrayDimensions = []
            v.Description = ua.LocalizedText("switch")
            
            await container.add_method(self.ns,"setup",self.setup_,[v],[v])

            # event
            et = await self.nodes.base_event_type.add_object_type(2, 'event')
            await et.add_property(2, 't', ua.Variant(0, ua.VariantType.DateTime))
            await et.add_property(2, 'u', ua.Variant(0, ua.VariantType.Int64))
            await et.add_property(2, 'y', ua.Variant(0., ua.VariantType.Double))
            self.e = await self.get_event_generator(et, container)
        
    async def reset_(self):
        pass

    async def nodes_(self,nodeid):
        return await self.get_node(nodeid).get_children()
    
    async def variable_(self, nodeid, name):
        nodes = await self.nodes_(nodeid)
        for node in nodes:
            bn = await node.read_browse_name()
            nc = await node.read_node_class()
            if (bn.Name == name) and (nc == ua.NodeClass.Variable):
                return node
        return None
    
    async def method_(self, nodeid, name):
        nodes = await self.nodes_(nodeid)
        for node in nodes:
            bn = await node.read_browse_name()
            nc = await node.read_node_class()
            if (bn.Name == name) and (nc == ua.NodeClass.Method):
                return node
        return None
    
    async def write_(self, nodeid, name, value):
        node = await self.variable_(nodeid, name)
        if node is not None:
            await self.write_attribute_value(node.nodeid,ua.DataValue(value))
        return node
    
    async def read_(self, nodeid, name):
        node: Node = await self.variable_(nodeid, name)
        if node is not None:
            value = await node.read_data_value()            
            return value.Value.Value
        return None
    
    async def event_(self,message,attr):
        try:
            #node = await self.nodes.root.get_child(["0:Types", "0:EventTypes", "0:BaseEventType", f"2:{name}"])
            self.e.event.Message = message        
            for key in attr.keys(): setattr(self.e.event,key,attr[key])                        
            await self.e.trigger()
        except Exception as e:
            _logger.error(e)
            return False
        return True

    moment_data = None
    
    async def moment_(self, moment):

        if self.moment_data is None:
        
            from _helper import DataLoad
            
            name = "model.q.3"
            fname = os.path.join(os.getcwd(),"data","tclab.%s.csv"%(name))
            
            tt,ut,yt,data_size = DataLoad.load_(fname)

            self.moment_data = dict(
                t=tt,u=ut,y=yt,size=data_size
            )

        if moment >= self.moment_data['size']: moment = 0

        return moment+1,self.moment_data['t'][moment],self.moment_data['u'][moment],self.moment_data['y'][moment]

    cancel = False
    count = 0
    delay = .5 # s
    
    async def loop_(self):
        
        _logger.debug('loop_')

        try:

            async with self:
                moment = 0
                while not self.cancel:

                    nodeid = "ns=2;i=1"
                    
                    # retrieve one simulation setup of 
                    # t_: time, u_: Q-switch, y_: T-temperature by switch
                    moment,t_,u_,y_ = await self.moment_(moment)
                    u_ = int(u_)
                    y_ = float(y_)                
                    t_ = datetime.now()

                    # write to single opcua variables
                    await self.write_(nodeid, "u", u_)
                    await self.write_(nodeid, "y", y_)
                    await self.write_(nodeid, "t", t_)

                    # write to an opcua array together
                    a = await self.variable_(nodeid, "a")
                    y_ = np.int64(y_*1000)
                    t_ = np.int64(t_.timestamp())
                    value = [u_,y_,t_]
                    await self.write_attribute_value(a.nodeid,ua.DataValue(value))

                    await asyncio.sleep(self.delay)

                    if self.count == 1:
                                            
                        # send an alive event, too
                        u = await self.read_(nodeid, "u")                    
                        y = await self.read_(nodeid, "y")
                        t = await self.read_(nodeid, "t")
                        await self.event_(message='alive',attr=dict(u=u,y=y,t=t))

                        self.count = 0

                    self.count += 1

        except Exception as e:
            _logger.error(e)
            return False

        return True

    async def namespace_(self):
        return await self.get_namespace_array()
    
async def run_():

    args = {
        "url": "opc.tcp://192.168.178.20:4841/freeopcua/server/",
        "name": "opc-server.1",
        "uri": "http://localhost.server.nob",
        "certificate": os.path.join(os.getcwd(),"cert","certificate.der"),
        "private_key": os.path.join(os.getcwd(),"cert","private.pem")
    }

    server = server_(args=args)    
    await server.start_()
    await server.load_()
    await server.loop_()

if __name__ == "__main__":
    os.system("cls")
    asyncio.run(run_())
