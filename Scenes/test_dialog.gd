extends Control

@onready var menu_button: MenuButton = $MenuBar/MenuButton
@onready var color_rect: ColorRect = $ColorRect

var menu_items: PopupMenu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_items = menu_button.get_popup()
	menu_items.connect("id_pressed", printIfButtonPressed)
	
func printIfButtonPressed(id) -> void:
	match id:
		0:
			open_file_dialog()
		1:
			testFetch()
#-------------------------------------------------------------------------------
#------------------------------>>>>FETCH_HTTP<<<<-------------------------------
func testFetch() -> void:
	var newHttpRequest: HTTPRequest = HTTPRequest.new()
	add_child(newHttpRequest)
	newHttpRequest.request_completed.connect(_on_request_complete)
	newHttpRequest.request("http://192.168.0.49:3030/test/data")
	
func _on_request_complete(result, resCode, headers, body) -> void:
	print("Server Log: ", result, resCode, headers)
	var data = {
		message = ""
	}
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json != null:
		data.message = json.message
	else: data.message = body.get_string_from_utf8()
	
	var newLabel = Label.new()
	newLabel.text = data.message
	newLabel.global_position = Vector2(300, 300)
	color_rect.add_child(newLabel)

#----------------------->>>>OPEN_DIALOG<<<<-------------------------------------
func open_file_dialog() -> void:
	var dialog: FileDialog = FileDialog.new()
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.connect("file_selected", _on_file_selected)
	add_child(dialog)
	dialog.popup_centered()

func _on_file_selected(path: String) -> void:
	print("Ausgewählte Datei:", path)
#-------------------------------------------------------------------------------

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
