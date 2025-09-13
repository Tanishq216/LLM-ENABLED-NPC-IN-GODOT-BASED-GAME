extends Label
var url = 'https://large-likely-chicken.ngrok-free.app/AcchaProject'
@onready var https_request = $HTTPRequest
var response = null  # Variable to store the response
var can_request = true  # Flag to prevent multiple simultaneous requests
@onready var input_node = $"../../../../CenterContainer/LineEdit"
@onready var container_input = $"../../../../CenterContainer"
var boolean = 0  # Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the request_completed signal
	https_request.request_completed.connect(self._on_request_completed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boolean == 0:
		Global.area_entered = 1
		boolean = 1
	if Input.is_action_just_released("ui_text_completion_accept"):
		Global.input_message = input_node.text
		input_node.clear()
		self.text = ""
		container_input.visible = false
		send_post_request()

func send_post_request():
	# Check if a request is already in progress
	if not can_request:
		print("Request already in progress. Please wait.")
		return
	
	# Prepare the data dictionary
	
	var data = {
		"character": Global.area_entered,  # Assuming Global.area_entered contains the character value
		"input": Global.input_message  # Assuming Global.Input contains the input text
	}
	
	# Convert data to JSON string
	var body = JSON.stringify(data)
	print(body)
	# Set headers
	var headers = ["Content-Type: application/json"]
	
	# Send the POST request
	var error = https_request.request(
		url, 
		headers, 
		HTTPClient.METHOD_POST, 
		body
	)
	
	# Check for request errors
	if error != OK:
		print("An error occurred in the HTTP request.")
		can_request = true
	else:
		# Disable further requests until this one completes
		can_request = false

# Callback function to handle the completed request
func _on_request_completed(result, response_code, headers, body):
	# Re-enable requests
	can_request = true
	
	if result == HTTPRequest.RESULT_SUCCESS:
		# Parse the response body
		response = JSON.parse_string(body.get_string_from_utf8())
		
		# Optional: Update the label text with the response
		self.text = str(response)
		
		# Print the response for debugging
		print("Response received:", response)
	else:
		print("HTTP request failed with result: ", result)

