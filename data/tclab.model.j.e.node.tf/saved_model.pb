��
��
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( �
�
BiasAdd

value"T	
bias"T
output"T""
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
$
DisableCopyOnRead
resource�
.
Identity

input"T
output"T"	
Ttype
u
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:
2	
�
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool("
allow_missing_filesbool( �

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype�
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ��
@
StaticRegexFullMatch	
input

output
"
patternstring
�
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
-
Tanh
x"T
y"T"
Ttype:

2
�
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 �"serve*2.12.02v2.12.0-rc1-12-g0db597d0d758��
p
dense_1/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_1/bias
i
 dense_1/bias/Read/ReadVariableOpReadVariableOpdense_1/bias*
_output_shapes
:*
dtype0
x
dense_1/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:2*
shared_namedense_1/kernel
q
"dense_1/kernel/Read/ReadVariableOpReadVariableOpdense_1/kernel*
_output_shapes

:2*
dtype0
l

dense/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:2*
shared_name
dense/bias
e
dense/bias/Read/ReadVariableOpReadVariableOp
dense/bias*
_output_shapes
:2*
dtype0
t
dense/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:2*
shared_namedense/kernel
m
 dense/kernel/Read/ReadVariableOpReadVariableOpdense/kernel*
_output_shapes

:2*
dtype0
W
serving_default_args_0Placeholder*
_output_shapes
: *
dtype0*
shape: 
q
serving_default_args_1Placeholder*#
_output_shapes
:���������*
dtype0*
shape:���������
�
StatefulPartitionedCallStatefulPartitionedCallserving_default_args_0serving_default_args_1dense/kernel
dense/biasdense_1/kerneldense_1/bias*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: *&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *.
f)R'
%__inference_signature_wrapper_5268734

NoOpNoOp
�
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*�
value�B� B�
�
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
func
	
signatures*
 

0
1
2
3*
 

0
1
2
3*
* 
�
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*

trace_0
trace_1* 

trace_0
trace_1* 
* 
�
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses*

serving_default* 
LF
VARIABLE_VALUEdense/kernel&variables/0/.ATTRIBUTES/VARIABLE_VALUE*
JD
VARIABLE_VALUE
dense/bias&variables/1/.ATTRIBUTES/VARIABLE_VALUE*
NH
VARIABLE_VALUEdense_1/kernel&variables/2/.ATTRIBUTES/VARIABLE_VALUE*
LF
VARIABLE_VALUEdense_1/bias&variables/3/.ATTRIBUTES/VARIABLE_VALUE*
* 

0*
* 
* 
* 
* 
* 
* 
* 
�
 	variables
!trainable_variables
"regularization_losses
#	keras_api
$__call__
*%&call_and_return_all_conditional_losses


kernel
bias*
�
&	variables
'trainable_variables
(regularization_losses
)	keras_api
*__call__
*+&call_and_return_all_conditional_losses

kernel
bias*
 

0
1
2
3*
 

0
1
2
3*
* 
�
,non_trainable_variables

-layers
.metrics
/layer_regularization_losses
0layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*
6
1trace_0
2trace_1
3trace_2
4trace_3* 
6
5trace_0
6trace_1
7trace_2
8trace_3* 
* 


0
1*


0
1*
* 
�
9non_trainable_variables

:layers
;metrics
<layer_regularization_losses
=layer_metrics
 	variables
!trainable_variables
"regularization_losses
$__call__
*%&call_and_return_all_conditional_losses
&%"call_and_return_conditional_losses*

>trace_0* 

?trace_0* 

0
1*

0
1*
* 
�
@non_trainable_variables

Alayers
Bmetrics
Clayer_regularization_losses
Dlayer_metrics
&	variables
'trainable_variables
(regularization_losses
*__call__
*+&call_and_return_all_conditional_losses
&+"call_and_return_conditional_losses*

Etrace_0* 

Ftrace_0* 
* 

0
1*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filenamedense/kernel
dense/biasdense_1/kerneldense_1/biasConst*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *)
f$R"
 __inference__traced_save_5268957
�
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamedense/kernel
dense/biasdense_1/kerneldense_1/bias*
Tin	
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *,
f'R%
#__inference__traced_restore_5268979��
�
�
,__inference_neural_ode_layer_call_fn_5268762
t
y
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalltyunknown	unknown_0	unknown_1	unknown_2*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: *&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268689^
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�
�
"__inference__wrapped_model_5268495

args_0

args_1G
5neural_ode_n_ode_dense_matmul_readvariableop_resource:2D
6neural_ode_n_ode_dense_biasadd_readvariableop_resource:2I
7neural_ode_n_ode_dense_1_matmul_readvariableop_resource:2F
8neural_ode_n_ode_dense_1_biasadd_readvariableop_resource:
identity��-neural_ode/n-ode/dense/BiasAdd/ReadVariableOp�,neural_ode/n-ode/dense/MatMul/ReadVariableOp�/neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOp�.neural_ode/n-ode/dense_1/MatMul/ReadVariableOpi
neural_ode/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"����   z
neural_ode/ReshapeReshapeargs_1!neural_ode/Reshape/shape:output:0*
T0*'
_output_shapes
:����������
,neural_ode/n-ode/dense/MatMul/ReadVariableOpReadVariableOp5neural_ode_n_ode_dense_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
neural_ode/n-ode/dense/MatMulMatMulneural_ode/Reshape:output:04neural_ode/n-ode/dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2�
-neural_ode/n-ode/dense/BiasAdd/ReadVariableOpReadVariableOp6neural_ode_n_ode_dense_biasadd_readvariableop_resource*
_output_shapes
:2*
dtype0�
neural_ode/n-ode/dense/BiasAddBiasAdd'neural_ode/n-ode/dense/MatMul:product:05neural_ode/n-ode/dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2~
neural_ode/n-ode/dense/TanhTanh'neural_ode/n-ode/dense/BiasAdd:output:0*
T0*'
_output_shapes
:���������2�
.neural_ode/n-ode/dense_1/MatMul/ReadVariableOpReadVariableOp7neural_ode_n_ode_dense_1_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
neural_ode/n-ode/dense_1/MatMulMatMulneural_ode/n-ode/dense/Tanh:y:06neural_ode/n-ode/dense_1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
/neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOpReadVariableOp8neural_ode_n_ode_dense_1_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
 neural_ode/n-ode/dense_1/BiasAddBiasAdd)neural_ode/n-ode/dense_1/MatMul:product:07neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������o
neural_ode/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        q
 neural_ode/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"      q
 neural_ode/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      �
neural_ode/strided_sliceStridedSlice)neural_ode/n-ode/dense_1/BiasAdd:output:0'neural_ode/strided_slice/stack:output:0)neural_ode/strided_slice/stack_1:output:0)neural_ode/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_mask_
IdentityIdentity!neural_ode/strided_slice:output:0^NoOp*
T0*
_output_shapes
: �
NoOpNoOp.^neural_ode/n-ode/dense/BiasAdd/ReadVariableOp-^neural_ode/n-ode/dense/MatMul/ReadVariableOp0^neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOp/^neural_ode/n-ode/dense_1/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 2^
-neural_ode/n-ode/dense/BiasAdd/ReadVariableOp-neural_ode/n-ode/dense/BiasAdd/ReadVariableOp2\
,neural_ode/n-ode/dense/MatMul/ReadVariableOp,neural_ode/n-ode/dense/MatMul/ReadVariableOp2b
/neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOp/neural_ode/n-ode/dense_1/BiasAdd/ReadVariableOp2`
.neural_ode/n-ode/dense_1/MatMul/ReadVariableOp.neural_ode/n-ode/dense_1/MatMul/ReadVariableOp:KG
#
_output_shapes
:���������
 
_user_specified_nameargs_1:> :

_output_shapes
: 
 
_user_specified_nameargs_0
�
�
'__inference_dense_layer_call_fn_5268879

inputs
unknown:2
	unknown_0:2
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������2*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_dense_layer_call_and_return_conditional_losses_5268510o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������2`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268591

inputs
dense_5268580:2
dense_5268582:2!
dense_1_5268585:2
dense_1_5268587:
identity��dense/StatefulPartitionedCall�dense_1/StatefulPartitionedCall�
dense/StatefulPartitionedCallStatefulPartitionedCallinputsdense_5268580dense_5268582*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������2*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_dense_layer_call_and_return_conditional_losses_5268510�
dense_1/StatefulPartitionedCallStatefulPartitionedCall&dense/StatefulPartitionedCall:output:0dense_1_5268585dense_1_5268587*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526w
IdentityIdentity(dense_1/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/StatefulPartitionedCall ^dense_1/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall2B
dense_1/StatefulPartitionedCalldense_1/StatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268564

inputs
dense_5268553:2
dense_5268555:2!
dense_1_5268558:2
dense_1_5268560:
identity��dense/StatefulPartitionedCall�dense_1/StatefulPartitionedCall�
dense/StatefulPartitionedCallStatefulPartitionedCallinputsdense_5268553dense_5268555*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������2*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_dense_layer_call_and_return_conditional_losses_5268510�
dense_1/StatefulPartitionedCallStatefulPartitionedCall&dense/StatefulPartitionedCall:output:0dense_1_5268558dense_1_5268560*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526w
IdentityIdentity(dense_1/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/StatefulPartitionedCall ^dense_1/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall2B
dense_1/StatefulPartitionedCalldense_1/StatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
)__inference_dense_1_layer_call_fn_5268899

inputs
unknown:2
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������2: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������2
 
_user_specified_nameinputs
�

�
B__inference_dense_layer_call_and_return_conditional_losses_5268890

inputs0
matmul_readvariableop_resource:2-
biasadd_readvariableop_resource:2
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:2*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:2*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2P
TanhTanhBiasAdd:output:0*
T0*'
_output_shapes
:���������2W
IdentityIdentityTanh:y:0^NoOp*
T0*'
_output_shapes
:���������2w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268810
t
y<
*n_ode_dense_matmul_readvariableop_resource:29
+n_ode_dense_biasadd_readvariableop_resource:2>
,n_ode_dense_1_matmul_readvariableop_resource:2;
-n_ode_dense_1_biasadd_readvariableop_resource:
identity��"n-ode/dense/BiasAdd/ReadVariableOp�!n-ode/dense/MatMul/ReadVariableOp�$n-ode/dense_1/BiasAdd/ReadVariableOp�#n-ode/dense_1/MatMul/ReadVariableOp^
Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"����   _
ReshapeReshapeyReshape/shape:output:0*
T0*'
_output_shapes
:����������
!n-ode/dense/MatMul/ReadVariableOpReadVariableOp*n_ode_dense_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
n-ode/dense/MatMulMatMulReshape:output:0)n-ode/dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2�
"n-ode/dense/BiasAdd/ReadVariableOpReadVariableOp+n_ode_dense_biasadd_readvariableop_resource*
_output_shapes
:2*
dtype0�
n-ode/dense/BiasAddBiasAddn-ode/dense/MatMul:product:0*n-ode/dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2h
n-ode/dense/TanhTanhn-ode/dense/BiasAdd:output:0*
T0*'
_output_shapes
:���������2�
#n-ode/dense_1/MatMul/ReadVariableOpReadVariableOp,n_ode_dense_1_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
n-ode/dense_1/MatMulMatMuln-ode/dense/Tanh:y:0+n-ode/dense_1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
$n-ode/dense_1/BiasAdd/ReadVariableOpReadVariableOp-n_ode_dense_1_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
n-ode/dense_1/BiasAddBiasAddn-ode/dense_1/MatMul:product:0,n-ode/dense_1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"      f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      �
strided_sliceStridedSlicen-ode/dense_1/BiasAdd:output:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskT
IdentityIdentitystrided_slice:output:0^NoOp*
T0*
_output_shapes
: �
NoOpNoOp#^n-ode/dense/BiasAdd/ReadVariableOp"^n-ode/dense/MatMul/ReadVariableOp%^n-ode/dense_1/BiasAdd/ReadVariableOp$^n-ode/dense_1/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 2H
"n-ode/dense/BiasAdd/ReadVariableOp"n-ode/dense/BiasAdd/ReadVariableOp2F
!n-ode/dense/MatMul/ReadVariableOp!n-ode/dense/MatMul/ReadVariableOp2L
$n-ode/dense_1/BiasAdd/ReadVariableOp$n-ode/dense_1/BiasAdd/ReadVariableOp2J
#n-ode/dense_1/MatMul/ReadVariableOp#n-ode/dense_1/MatMul/ReadVariableOp:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�
�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268669
t
y
n_ode_5268655:2
n_ode_5268657:2
n_ode_5268659:2
n_ode_5268661:
identity��n-ode/StatefulPartitionedCall^
Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"����   _
ReshapeReshapeyReshape/shape:output:0*
T0*'
_output_shapes
:����������
n-ode/StatefulPartitionedCallStatefulPartitionedCallReshape:output:0n_ode_5268655n_ode_5268657n_ode_5268659n_ode_5268661*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268564d
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"      f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      �
strided_sliceStridedSlice&n-ode/StatefulPartitionedCall:output:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskT
IdentityIdentitystrided_slice:output:0^NoOp*
T0*
_output_shapes
: f
NoOpNoOp^n-ode/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 2>
n-ode/StatefulPartitionedCalln-ode/StatefulPartitionedCall:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�
�
,__inference_neural_ode_layer_call_fn_5268748
t
y
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalltyunknown	unknown_0	unknown_1	unknown_2*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: *&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268669^
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�	
�
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526

inputs0
matmul_readvariableop_resource:2-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:2*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:���������w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������2: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������2
 
_user_specified_nameinputs
�	
�
D__inference_dense_1_layer_call_and_return_conditional_losses_5268909

inputs0
matmul_readvariableop_resource:2-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:2*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:���������w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������2: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������2
 
_user_specified_nameinputs
�
�
%__inference_signature_wrapper_5268734

args_0

args_1
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallargs_0args_1unknown	unknown_0	unknown_1	unknown_2*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: *&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *+
f&R$
"__inference__wrapped_model_5268495^
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:KG
#
_output_shapes
:���������
 
_user_specified_nameargs_1:> :

_output_shapes
: 
 
_user_specified_nameargs_0
�
�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268786
t
y<
*n_ode_dense_matmul_readvariableop_resource:29
+n_ode_dense_biasadd_readvariableop_resource:2>
,n_ode_dense_1_matmul_readvariableop_resource:2;
-n_ode_dense_1_biasadd_readvariableop_resource:
identity��"n-ode/dense/BiasAdd/ReadVariableOp�!n-ode/dense/MatMul/ReadVariableOp�$n-ode/dense_1/BiasAdd/ReadVariableOp�#n-ode/dense_1/MatMul/ReadVariableOp^
Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"����   _
ReshapeReshapeyReshape/shape:output:0*
T0*'
_output_shapes
:����������
!n-ode/dense/MatMul/ReadVariableOpReadVariableOp*n_ode_dense_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
n-ode/dense/MatMulMatMulReshape:output:0)n-ode/dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2�
"n-ode/dense/BiasAdd/ReadVariableOpReadVariableOp+n_ode_dense_biasadd_readvariableop_resource*
_output_shapes
:2*
dtype0�
n-ode/dense/BiasAddBiasAddn-ode/dense/MatMul:product:0*n-ode/dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2h
n-ode/dense/TanhTanhn-ode/dense/BiasAdd:output:0*
T0*'
_output_shapes
:���������2�
#n-ode/dense_1/MatMul/ReadVariableOpReadVariableOp,n_ode_dense_1_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
n-ode/dense_1/MatMulMatMuln-ode/dense/Tanh:y:0+n-ode/dense_1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
$n-ode/dense_1/BiasAdd/ReadVariableOpReadVariableOp-n_ode_dense_1_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
n-ode/dense_1/BiasAddBiasAddn-ode/dense_1/MatMul:product:0,n-ode/dense_1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"      f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      �
strided_sliceStridedSlicen-ode/dense_1/BiasAdd:output:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskT
IdentityIdentitystrided_slice:output:0^NoOp*
T0*
_output_shapes
: �
NoOpNoOp#^n-ode/dense/BiasAdd/ReadVariableOp"^n-ode/dense/MatMul/ReadVariableOp%^n-ode/dense_1/BiasAdd/ReadVariableOp$^n-ode/dense_1/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 2H
"n-ode/dense/BiasAdd/ReadVariableOp"n-ode/dense/BiasAdd/ReadVariableOp2F
!n-ode/dense/MatMul/ReadVariableOp!n-ode/dense/MatMul/ReadVariableOp2L
$n-ode/dense_1/BiasAdd/ReadVariableOp$n-ode/dense_1/BiasAdd/ReadVariableOp2J
#n-ode/dense_1/MatMul/ReadVariableOp#n-ode/dense_1/MatMul/ReadVariableOp:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�
�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268689
t
y
n_ode_5268675:2
n_ode_5268677:2
n_ode_5268679:2
n_ode_5268681:
identity��n-ode/StatefulPartitionedCall^
Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"����   _
ReshapeReshapeyReshape/shape:output:0*
T0*'
_output_shapes
:����������
n-ode/StatefulPartitionedCallStatefulPartitionedCallReshape:output:0n_ode_5268675n_ode_5268677n_ode_5268679n_ode_5268681*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268591d
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        f
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"      f
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      �
strided_sliceStridedSlice&n-ode/StatefulPartitionedCall:output:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskT
IdentityIdentitystrided_slice:output:0^NoOp*
T0*
_output_shapes
: f
NoOpNoOp^n-ode/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
: :���������: : : : 2>
n-ode/StatefulPartitionedCalln-ode/StatefulPartitionedCall:FB
#
_output_shapes
:���������

_user_specified_namey:9 5

_output_shapes
: 

_user_specified_namet
�
�
'__inference_n-ode_layer_call_fn_5268836

inputs
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268591o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
'__inference_n-ode_layer_call_fn_5268575
dense_input
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalldense_inputunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268564o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:T P
'
_output_shapes
:���������
%
_user_specified_namedense_input
�+
�
 __inference__traced_save_5268957
file_prefix5
#read_disablecopyonread_dense_kernel:21
#read_1_disablecopyonread_dense_bias:29
'read_2_disablecopyonread_dense_1_kernel:23
%read_3_disablecopyonread_dense_1_bias:
savev2_const

identity_9��MergeV2Checkpoints�Read/DisableCopyOnRead�Read/ReadVariableOp�Read_1/DisableCopyOnRead�Read_1/ReadVariableOp�Read_2/DisableCopyOnRead�Read_2/ReadVariableOp�Read_3/DisableCopyOnRead�Read_3/ReadVariableOpw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : �
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: u
Read/DisableCopyOnReadDisableCopyOnRead#read_disablecopyonread_dense_kernel"/device:CPU:0*
_output_shapes
 �
Read/ReadVariableOpReadVariableOp#read_disablecopyonread_dense_kernel^Read/DisableCopyOnRead"/device:CPU:0*
_output_shapes

:2*
dtype0i
IdentityIdentityRead/ReadVariableOp:value:0"/device:CPU:0*
T0*
_output_shapes

:2a

Identity_1IdentityIdentity:output:0"/device:CPU:0*
T0*
_output_shapes

:2w
Read_1/DisableCopyOnReadDisableCopyOnRead#read_1_disablecopyonread_dense_bias"/device:CPU:0*
_output_shapes
 �
Read_1/ReadVariableOpReadVariableOp#read_1_disablecopyonread_dense_bias^Read_1/DisableCopyOnRead"/device:CPU:0*
_output_shapes
:2*
dtype0i

Identity_2IdentityRead_1/ReadVariableOp:value:0"/device:CPU:0*
T0*
_output_shapes
:2_

Identity_3IdentityIdentity_2:output:0"/device:CPU:0*
T0*
_output_shapes
:2{
Read_2/DisableCopyOnReadDisableCopyOnRead'read_2_disablecopyonread_dense_1_kernel"/device:CPU:0*
_output_shapes
 �
Read_2/ReadVariableOpReadVariableOp'read_2_disablecopyonread_dense_1_kernel^Read_2/DisableCopyOnRead"/device:CPU:0*
_output_shapes

:2*
dtype0m

Identity_4IdentityRead_2/ReadVariableOp:value:0"/device:CPU:0*
T0*
_output_shapes

:2c

Identity_5IdentityIdentity_4:output:0"/device:CPU:0*
T0*
_output_shapes

:2y
Read_3/DisableCopyOnReadDisableCopyOnRead%read_3_disablecopyonread_dense_1_bias"/device:CPU:0*
_output_shapes
 �
Read_3/ReadVariableOpReadVariableOp%read_3_disablecopyonread_dense_1_bias^Read_3/DisableCopyOnRead"/device:CPU:0*
_output_shapes
:*
dtype0i

Identity_6IdentityRead_3/ReadVariableOp:value:0"/device:CPU:0*
T0*
_output_shapes
:_

Identity_7IdentityIdentity_6:output:0"/device:CPU:0*
T0*
_output_shapes
:�
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�
value�B�B&variables/0/.ATTRIBUTES/VARIABLE_VALUEB&variables/1/.ATTRIBUTES/VARIABLE_VALUEB&variables/2/.ATTRIBUTES/VARIABLE_VALUEB&variables/3/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPHw
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B B B �
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0Identity_1:output:0Identity_3:output:0Identity_5:output:0Identity_7:output:0savev2_const"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtypes	
2�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 h

Identity_8Identityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: S

Identity_9IdentityIdentity_8:output:0^NoOp*
T0*
_output_shapes
: �
NoOpNoOp^MergeV2Checkpoints^Read/DisableCopyOnRead^Read/ReadVariableOp^Read_1/DisableCopyOnRead^Read_1/ReadVariableOp^Read_2/DisableCopyOnRead^Read_2/ReadVariableOp^Read_3/DisableCopyOnRead^Read_3/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "!

identity_9Identity_9:output:0*
_input_shapes
: : : : : : 2(
MergeV2CheckpointsMergeV2Checkpoints20
Read/DisableCopyOnReadRead/DisableCopyOnRead2*
Read/ReadVariableOpRead/ReadVariableOp24
Read_1/DisableCopyOnReadRead_1/DisableCopyOnRead2.
Read_1/ReadVariableOpRead_1/ReadVariableOp24
Read_2/DisableCopyOnReadRead_2/DisableCopyOnRead2.
Read_2/ReadVariableOpRead_2/ReadVariableOp24
Read_3/DisableCopyOnReadRead_3/DisableCopyOnRead2.
Read_3/ReadVariableOpRead_3/ReadVariableOp:

_output_shapes
: :C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268547
dense_input
dense_5268536:2
dense_5268538:2!
dense_1_5268541:2
dense_1_5268543:
identity��dense/StatefulPartitionedCall�dense_1/StatefulPartitionedCall�
dense/StatefulPartitionedCallStatefulPartitionedCalldense_inputdense_5268536dense_5268538*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������2*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_dense_layer_call_and_return_conditional_losses_5268510�
dense_1/StatefulPartitionedCallStatefulPartitionedCall&dense/StatefulPartitionedCall:output:0dense_1_5268541dense_1_5268543*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526w
IdentityIdentity(dense_1/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/StatefulPartitionedCall ^dense_1/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall2B
dense_1/StatefulPartitionedCalldense_1/StatefulPartitionedCall:T P
'
_output_shapes
:���������
%
_user_specified_namedense_input
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268853

inputs6
$dense_matmul_readvariableop_resource:23
%dense_biasadd_readvariableop_resource:28
&dense_1_matmul_readvariableop_resource:25
'dense_1_biasadd_readvariableop_resource:
identity��dense/BiasAdd/ReadVariableOp�dense/MatMul/ReadVariableOp�dense_1/BiasAdd/ReadVariableOp�dense_1/MatMul/ReadVariableOp�
dense/MatMul/ReadVariableOpReadVariableOp$dense_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0u
dense/MatMulMatMulinputs#dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2~
dense/BiasAdd/ReadVariableOpReadVariableOp%dense_biasadd_readvariableop_resource*
_output_shapes
:2*
dtype0�
dense/BiasAddBiasAdddense/MatMul:product:0$dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2\

dense/TanhTanhdense/BiasAdd:output:0*
T0*'
_output_shapes
:���������2�
dense_1/MatMul/ReadVariableOpReadVariableOp&dense_1_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
dense_1/MatMulMatMuldense/Tanh:y:0%dense_1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
dense_1/BiasAdd/ReadVariableOpReadVariableOp'dense_1_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_1/BiasAddBiasAdddense_1/MatMul:product:0&dense_1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������g
IdentityIdentitydense_1/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/BiasAdd/ReadVariableOp^dense/MatMul/ReadVariableOp^dense_1/BiasAdd/ReadVariableOp^dense_1/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2<
dense/BiasAdd/ReadVariableOpdense/BiasAdd/ReadVariableOp2:
dense/MatMul/ReadVariableOpdense/MatMul/ReadVariableOp2@
dense_1/BiasAdd/ReadVariableOpdense_1/BiasAdd/ReadVariableOp2>
dense_1/MatMul/ReadVariableOpdense_1/MatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
'__inference_n-ode_layer_call_fn_5268602
dense_input
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalldense_inputunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268591o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:T P
'
_output_shapes
:���������
%
_user_specified_namedense_input
�
�
'__inference_n-ode_layer_call_fn_5268823

inputs
unknown:2
	unknown_0:2
	unknown_1:2
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*&
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_n-ode_layer_call_and_return_conditional_losses_5268564o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
#__inference__traced_restore_5268979
file_prefix/
assignvariableop_dense_kernel:2+
assignvariableop_1_dense_bias:23
!assignvariableop_2_dense_1_kernel:2-
assignvariableop_3_dense_1_bias:

identity_5��AssignVariableOp�AssignVariableOp_1�AssignVariableOp_2�AssignVariableOp_3�
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�
value�B�B&variables/0/.ATTRIBUTES/VARIABLE_VALUEB&variables/1/.ATTRIBUTES/VARIABLE_VALUEB&variables/2/.ATTRIBUTES/VARIABLE_VALUEB&variables/3/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPHz
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B B B �
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*(
_output_shapes
:::::*
dtypes	
2[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOpAssignVariableOpassignvariableop_dense_kernelIdentity:output:0"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_1AssignVariableOpassignvariableop_1_dense_biasIdentity_1:output:0"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_2AssignVariableOp!assignvariableop_2_dense_1_kernelIdentity_2:output:0"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_3AssignVariableOpassignvariableop_3_dense_1_biasIdentity_3:output:0"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 *
dtype0Y
NoOpNoOp"/device:CPU:0*&
 _has_manual_control_dependencies(*
_output_shapes
 �

Identity_4Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3^NoOp"/device:CPU:0*
T0*
_output_shapes
: U

Identity_5IdentityIdentity_4:output:0^NoOp_1*
T0*
_output_shapes
: �
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3*"
_acd_function_control_output(*
_output_shapes
 "!

identity_5Identity_5:output:0*
_input_shapes

: : : : : 2(
AssignVariableOp_1AssignVariableOp_12(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32$
AssignVariableOpAssignVariableOp:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268533
dense_input
dense_5268511:2
dense_5268513:2!
dense_1_5268527:2
dense_1_5268529:
identity��dense/StatefulPartitionedCall�dense_1/StatefulPartitionedCall�
dense/StatefulPartitionedCallStatefulPartitionedCalldense_inputdense_5268511dense_5268513*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������2*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_dense_layer_call_and_return_conditional_losses_5268510�
dense_1/StatefulPartitionedCallStatefulPartitionedCall&dense/StatefulPartitionedCall:output:0dense_1_5268527dense_1_5268529*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_dense_1_layer_call_and_return_conditional_losses_5268526w
IdentityIdentity(dense_1/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/StatefulPartitionedCall ^dense_1/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall2B
dense_1/StatefulPartitionedCalldense_1/StatefulPartitionedCall:T P
'
_output_shapes
:���������
%
_user_specified_namedense_input
�
�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268870

inputs6
$dense_matmul_readvariableop_resource:23
%dense_biasadd_readvariableop_resource:28
&dense_1_matmul_readvariableop_resource:25
'dense_1_biasadd_readvariableop_resource:
identity��dense/BiasAdd/ReadVariableOp�dense/MatMul/ReadVariableOp�dense_1/BiasAdd/ReadVariableOp�dense_1/MatMul/ReadVariableOp�
dense/MatMul/ReadVariableOpReadVariableOp$dense_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0u
dense/MatMulMatMulinputs#dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2~
dense/BiasAdd/ReadVariableOpReadVariableOp%dense_biasadd_readvariableop_resource*
_output_shapes
:2*
dtype0�
dense/BiasAddBiasAdddense/MatMul:product:0$dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2\

dense/TanhTanhdense/BiasAdd:output:0*
T0*'
_output_shapes
:���������2�
dense_1/MatMul/ReadVariableOpReadVariableOp&dense_1_matmul_readvariableop_resource*
_output_shapes

:2*
dtype0�
dense_1/MatMulMatMuldense/Tanh:y:0%dense_1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
dense_1/BiasAdd/ReadVariableOpReadVariableOp'dense_1_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_1/BiasAddBiasAdddense_1/MatMul:product:0&dense_1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������g
IdentityIdentitydense_1/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^dense/BiasAdd/ReadVariableOp^dense/MatMul/ReadVariableOp^dense_1/BiasAdd/ReadVariableOp^dense_1/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : : : 2<
dense/BiasAdd/ReadVariableOpdense/BiasAdd/ReadVariableOp2:
dense/MatMul/ReadVariableOpdense/MatMul/ReadVariableOp2@
dense_1/BiasAdd/ReadVariableOpdense_1/BiasAdd/ReadVariableOp2>
dense_1/MatMul/ReadVariableOpdense_1/MatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�

�
B__inference_dense_layer_call_and_return_conditional_losses_5268510

inputs0
matmul_readvariableop_resource:2-
biasadd_readvariableop_resource:2
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:2*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:2*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������2P
TanhTanhBiasAdd:output:0*
T0*'
_output_shapes
:���������2W
IdentityIdentityTanh:y:0^NoOp*
T0*'
_output_shapes
:���������2w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs"�
L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
serving_default�
(
args_0
serving_default_args_0:0 
5
args_1+
serving_default_args_1:0���������+
output_1
StatefulPartitionedCall:0 tensorflow/serving/predict:�j
�
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_default_save_signature
func
	
signatures"
_tf_keras_model
<

0
1
2
3"
trackable_list_wrapper
<

0
1
2
3"
trackable_list_wrapper
 "
trackable_list_wrapper
�
non_trainable_variables

layers
metrics
layer_regularization_losses
layer_metrics
	variables
trainable_variables
regularization_losses
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
�
trace_0
trace_12�
,__inference_neural_ode_layer_call_fn_5268748
,__inference_neural_ode_layer_call_fn_5268762�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 ztrace_0ztrace_1
�
trace_0
trace_12�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268786
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268810�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 ztrace_0ztrace_1
�B�
"__inference__wrapped_model_5268495args_0args_1"�
���
FullArgSpec
args� 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses"
_tf_keras_sequential
,
serving_default"
signature_map
:22dense/kernel
:22
dense/bias
 :22dense_1/kernel
:2dense_1/bias
 "
trackable_list_wrapper
'
0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�B�
,__inference_neural_ode_layer_call_fn_5268748ty"�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 
�B�
,__inference_neural_ode_layer_call_fn_5268762ty"�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 
�B�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268786ty"�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 
�B�
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268810ty"�
���
FullArgSpec
args�

jt
jy
varargs
 
varkw
 
defaults
 

kwonlyargs�

jtraining%
kwonlydefaults�

trainingp 
annotations� *
 
�
 	variables
!trainable_variables
"regularization_losses
#	keras_api
$__call__
*%&call_and_return_all_conditional_losses


kernel
bias"
_tf_keras_layer
�
&	variables
'trainable_variables
(regularization_losses
)	keras_api
*__call__
*+&call_and_return_all_conditional_losses

kernel
bias"
_tf_keras_layer
<

0
1
2
3"
trackable_list_wrapper
<

0
1
2
3"
trackable_list_wrapper
 "
trackable_list_wrapper
�
,non_trainable_variables

-layers
.metrics
/layer_regularization_losses
0layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
�
1trace_0
2trace_1
3trace_2
4trace_32�
'__inference_n-ode_layer_call_fn_5268575
'__inference_n-ode_layer_call_fn_5268602
'__inference_n-ode_layer_call_fn_5268823
'__inference_n-ode_layer_call_fn_5268836�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 z1trace_0z2trace_1z3trace_2z4trace_3
�
5trace_0
6trace_1
7trace_2
8trace_32�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268533
B__inference_n-ode_layer_call_and_return_conditional_losses_5268547
B__inference_n-ode_layer_call_and_return_conditional_losses_5268853
B__inference_n-ode_layer_call_and_return_conditional_losses_5268870�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 z5trace_0z6trace_1z7trace_2z8trace_3
�B�
%__inference_signature_wrapper_5268734args_0args_1"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
.

0
1"
trackable_list_wrapper
.

0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
�
9non_trainable_variables

:layers
;metrics
<layer_regularization_losses
=layer_metrics
 	variables
!trainable_variables
"regularization_losses
$__call__
*%&call_and_return_all_conditional_losses
&%"call_and_return_conditional_losses"
_generic_user_object
�
>trace_02�
'__inference_dense_layer_call_fn_5268879�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 z>trace_0
�
?trace_02�
B__inference_dense_layer_call_and_return_conditional_losses_5268890�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 z?trace_0
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
�
@non_trainable_variables

Alayers
Bmetrics
Clayer_regularization_losses
Dlayer_metrics
&	variables
'trainable_variables
(regularization_losses
*__call__
*+&call_and_return_all_conditional_losses
&+"call_and_return_conditional_losses"
_generic_user_object
�
Etrace_02�
)__inference_dense_1_layer_call_fn_5268899�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 zEtrace_0
�
Ftrace_02�
D__inference_dense_1_layer_call_and_return_conditional_losses_5268909�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 zFtrace_0
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�B�
'__inference_n-ode_layer_call_fn_5268575dense_input"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
'__inference_n-ode_layer_call_fn_5268602dense_input"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
'__inference_n-ode_layer_call_fn_5268823inputs"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
'__inference_n-ode_layer_call_fn_5268836inputs"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268533dense_input"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268547dense_input"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268853inputs"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268870inputs"�
���
FullArgSpec)
args!�
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�B�
'__inference_dense_layer_call_fn_5268879inputs"�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
B__inference_dense_layer_call_and_return_conditional_losses_5268890inputs"�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�B�
)__inference_dense_1_layer_call_fn_5268899inputs"�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
D__inference_dense_1_layer_call_and_return_conditional_losses_5268909inputs"�
���
FullArgSpec
args�

jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 �
"__inference__wrapped_model_5268495h
<�9
2�/
�
args_0 
�
args_1���������
� ""�

output_1�
output_1 �
D__inference_dense_1_layer_call_and_return_conditional_losses_5268909c/�,
%�"
 �
inputs���������2
� ",�)
"�
tensor_0���������
� �
)__inference_dense_1_layer_call_fn_5268899X/�,
%�"
 �
inputs���������2
� "!�
unknown����������
B__inference_dense_layer_call_and_return_conditional_losses_5268890c
/�,
%�"
 �
inputs���������
� ",�)
"�
tensor_0���������2
� �
'__inference_dense_layer_call_fn_5268879X
/�,
%�"
 �
inputs���������
� "!�
unknown���������2�
B__inference_n-ode_layer_call_and_return_conditional_losses_5268533r
<�9
2�/
%�"
dense_input���������
p

 
� ",�)
"�
tensor_0���������
� �
B__inference_n-ode_layer_call_and_return_conditional_losses_5268547r
<�9
2�/
%�"
dense_input���������
p 

 
� ",�)
"�
tensor_0���������
� �
B__inference_n-ode_layer_call_and_return_conditional_losses_5268853m
7�4
-�*
 �
inputs���������
p

 
� ",�)
"�
tensor_0���������
� �
B__inference_n-ode_layer_call_and_return_conditional_losses_5268870m
7�4
-�*
 �
inputs���������
p 

 
� ",�)
"�
tensor_0���������
� �
'__inference_n-ode_layer_call_fn_5268575g
<�9
2�/
%�"
dense_input���������
p

 
� "!�
unknown����������
'__inference_n-ode_layer_call_fn_5268602g
<�9
2�/
%�"
dense_input���������
p 

 
� "!�
unknown����������
'__inference_n-ode_layer_call_fn_5268823b
7�4
-�*
 �
inputs���������
p

 
� "!�
unknown����������
'__inference_n-ode_layer_call_fn_5268836b
7�4
-�*
 �
inputs���������
p 

 
� "!�
unknown����������
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268786g
B�?
(�%

�
t 
�
y���������
�

trainingp"�
�
tensor_0 
� �
G__inference_neural_ode_layer_call_and_return_conditional_losses_5268810g
B�?
(�%

�
t 
�
y���������
�

trainingp "�
�
tensor_0 
� �
,__inference_neural_ode_layer_call_fn_5268748\
B�?
(�%

�
t 
�
y���������
�

trainingp"�
unknown �
,__inference_neural_ode_layer_call_fn_5268762\
B�?
(�%

�
t 
�
y���������
�

trainingp "�
unknown �
%__inference_signature_wrapper_5268734|
P�M
� 
F�C

args_0�
args_0 
&
args_1�
args_1���������""�

output_1�
output_1 