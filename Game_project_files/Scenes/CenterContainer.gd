extends CenterContainer
@onready var input_node = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false 
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("message"):
		self.visible = true
		input_node.grab_focus()
	#if Input.is_action_pressed("ui_text_completion_accept"):
		#Global.input_message = input_node.text
		#input_node.clear()
		#self.visible = false

