extends Skeleton3D

var bone_1
var bone_2
var time := 0.0
var amplitude := 1.0  # qué tanto se mueven
var speed := 1      # qué tan rápido

func _ready():
	bone_1 = find_bone("Bone.001")
	bone_2 = find_bone("Bone.002")


func _process(delta):
	time += delta * speed
	var offset := sin(time) * amplitude

	var pose_1 = get_bone_pose_position(bone_1)
	pose_1.x = offset
	set_bone_pose_position(bone_1, pose_1)

	var pose_2 = get_bone_pose_position(bone_2)
	pose_2.z = offset
	set_bone_pose_position(bone_2, pose_2)
