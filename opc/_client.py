
from asyncua import Client,Node,ua
from asyncua.common.subscription import Subscription,DataChangeNotif
from asyncua.crypto import security_policies
from asyncua.tools import endpoint_to_strings

import asyncua.common.utils as utils

import asyncio
import os
import datetime
import time

from codetiming import Timer

from typing import List,Union,Iterable,Any

import logging
logging.basicConfig(level=logging.ERROR)

_logger = logging.getLogger(__name__)
_logger.name = "_client_"
_logger.setLevel(logging.DEBUG)
def filter_(record: logging.Filter):
    if isinstance(record.msg,str):
        return not record.msg.startswith("asyncua")
    return True
_logger.addFilter(filter_)

class DataChangeQueue(asyncio.Queue):

    def __init__(self, maxsize: int = 0) -> None:
        super().__init__(maxsize)

    async def put(self, item: Any):
        return await super().put(item)
    
    async def get(self):
        return await super().get()

class DataChangeItem():

    index = None
    id = None
    value = None
    time = datetime.datetime.now()

    def __init__(self, index, id, value, time=None):
        self.index = index
        self.id = id
        self.value = value
        self.time = time

class DataChangeHandler:   

    queue: DataChangeQueue = None

    def __init__(self, queue: DataChangeQueue) -> None:
        self.queue = queue

    async def datachange_notification(self, node: Node, val, data: DataChangeNotif):
        item = DataChangeItem(node.nodeid.NamespaceIndex, node.nodeid.Identifier, val, time=time.time())
        _logger.debug(f"notify node by {item.id};{item.value};{data}")
        await self.queue.put(item)

    async def event_notification(self, event: ua.EventNotificationList):
        """
        called for every event notification from server
        """
        pass

    async def status_change_notification(self, status: ua.StatusChangeNotification):
        """
        called for every status change notification from server
        """
        pass

    @staticmethod
    async def execute_(queue: DataChangeQueue):    
        while not queue.empty():
            size = queue.qsize()
            node = await queue.get()         
            _logger.debug(f"({size}) got node by {node.id};{node.value}")
            await asyncio.sleep(.1) 

class EventsHandler:

    def __init__(self) -> None:
        pass

    async def datachange_notification(self, node: Node, val, data: DataChangeNotif):
        """
        called for every datachange notification from server
        """
        pass

    async def event_notification(self, event: ua.EventNotificationList):
        """
        called for every event notification from server
        """
        pass

    async def status_change_notification(self, status: ua.StatusChangeNotification):
        """
        called for every status change notification from server
        """
        pass


class client_(Client):

    _connected = False

    def __init__(self, args):
        self.args = args
        super().__init__(url=args["url"],timeout=args["timeout"])

    async def connect_(self,password=None):
        
        _logger.debug("connect_")
        
        try:
            
            if self._connected: self.disconnect_()

            if (self.args["certificate"] is not None) and (password is not None):
                await self.set_security(
                    security_policies.SecurityPolicyBasic256Sha256,
                    certificate=self.args["certificate"],
                    private_key=self.args["private_key"], private_key_password=password,
                    server_certificate=self.args["certificate"],
                )
            
            await self.connect()            
            self._connected = True

            await self.load_data_type_definitions()
            
        except Exception as e:
            _logger.error(e)
            self._connected = False
        
        return self._connected

    async def disconnect_(self):

        _logger.debug(f"disconnect_:{self._connected}")

        if not self._connected:
            return
        try:
            await self.disconnect()
            _logger.info("disconnected")
        finally:            
            self.reset_()

    def reset_(self):
        self._connected = False

    async def node_(self, name):
        return await self.get_node(name)

    @staticmethod
    async def server_state_(args) -> int:
        rc = -1
        try:
            client = client_(args)
            await client.connect_()    
            rc = await client.get_node("ns=0;i=2259").read_value()
        except:
            rc = -1
        finally:
            await client.disconnect_()
        return rc==0,rc
        
    @staticmethod
    async def service_level_(args) -> int:
        rc = "unknown"
        try:
            client = client_(args)
            await client.connect_()    
            v = await client.get_node("ns=0;i=2267").read_value()
            if v >= 200: rc = "healty"
            elif v >= 2 and v <= 199: rc = "degraded"            
            elif v == 1: rc = "no data"
            elif v == 0: rc = "maintenance"
            else: rc = "out of range"
        except:
            rc = "unknown"
        finally:
            await client.disconnect_()
        return rc=="healty",rc
    
    @staticmethod
    async def operation_limits_(args):
        rc = []
        try:
            client = client_(args)
            await client.connect_()
            nn = await client.get_node("ns=0;i=11704").get_children()
            for n in nn:
                name = await n.read_display_name()
                value = await n.read_value()
                rc.append([name,value])
        except:
            rc = []
        finally:
            await client.disconnect_()
        return len(rc)>0,rc    

    @staticmethod
    async def server_endpoints_(args):
        rc = []
        try:
            client = client_(args)
            await client.connect_()
            pp = await client.connect_and_get_server_endpoints()
            for i,p in enumerate(pp, start=1):
                for (n,v) in endpoint_to_strings(p):
                    rc.append([i,n,v])                       
        except:
            rc = []
        finally:
            await client.disconnect_()
        return len(rc)>0,rc
    
    @staticmethod
    async def available_(args):

        avl,val = await client_.server_state_(args)
        if not avl:
            _logger.error("server state %d"%(val))
            return False
        _logger.info("server state %d"%(val))

        avl,val = await client_.service_level_(args)
        if not avl:
            _logger.error("service level is %s"%(val))
            return False
        _logger.info("service level %s"%(val))
        
        avl,val = await client_.server_endpoints_(args)
        if not avl:
            _logger.error("no server endpoints %s"%(val))        
            return False
        _logger.info("server endpoints",val)

        return True

    subscriptions = dict(
        data_change=None,
        events=None
        )

    async def register_(self, data_change=True,events=True):

        if data_change:

            _logger.debug("register_:data_change")

            try:                
                subscription = await self.create_subscription(
                    period=500,
                    handler=DataChangeHandler(queue=DataChangeQueue()),
                    publishing=True
                    )
                node = self.get_node("ns=2;i=1")
                nodes = await node.get_variables()        
                handles = await subscription.subscribe_data_change(
                    nodes, 
                    monitoring=ua.MonitoringMode.Reporting)
                self.subscriptions['data_change'] = dict(item=subscription,handles=handles)
            except Exception as e:
                self.subscriptions['data_change'] = None
                _logger.error(e)
                data_change = False

        if events:

            _logger.debug("register_:events")

            try:                
                subscription = await self.create_subscription(
                    period=500,
                    handler=EventsHandler(),
                    publishing=True
                    )
                
                #node = await self.nodes.root.get_child(["0:Objects","2:container"])
                #event = await self.nodes.root.get_child(["0:Types", "0:EventTypes", "0:BaseEventType", "2:event"])

                node = self.get_node("ns=2;i=1")
                event = self.get_node("ns=2;i=8")
                handles = await subscription.subscribe_events(node,[event.nodeid])
                self.subscriptions['events'] = dict(item=subscription,handles=handles)

            except Exception as e:
                self.subscriptions['events'] = None
                _logger.error(e)
                events = False
        
        return data_change or events
    
    async def unregister_(self,keys=None):
        if keys is None:
            keys = self.subscriptions.keys()
        for key in keys:
            try:                
                entry = self.subscriptions[key]
                if entry is not None:                    
                    subscription: Subscription = entry['item']
                    handles = entry['handles']                    
                    await subscription.unsubscribe(handles)
                    _logger.debug(f"unregister_:{key}:{handles}")
            except Exception as e:
                _logger.error(e)
            finally:
                pass

async def run_():

    args = {
        "url": "opc.tcp://localhost:4841/freeopcua/server/",    
        "timeout": 10,
        "uri": "http://localhost.server.nob",
        "certificate": os.path.join(os.getcwd(),"cert","certificate.der"),
        "private_key": os.path.join(os.getcwd(),"cert","private.pem")
    }
    
    client = client_(args=args)
    await client.connect_()

    # subscribe to listen
    await client.register_(events=False)
    
    delay = 5
    _logger.debug(f"wait for {delay}s")
    await asyncio.sleep(delay)

    await client.unregister_()
    await client.disconnect_()

    with Timer(text="elapsed time: {:.1f}"):
        handler = client.subscriptions['data_change']['item']._handler
        if handler is not None:
            queue = handler.queue
            await asyncio.gather(
                asyncio.create_task(DataChangeHandler.execute_(queue))
                )

if __name__ == "__main__":
    os.system("cls")
    asyncio.run(run_())