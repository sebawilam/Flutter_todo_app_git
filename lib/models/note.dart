
class Note {

	int _id;
	String _title;
	String _description;
	String _date;
	int _priority;
	String _date1;

	Note(this._title, this._date, this._priority, this._date1, [this._description]);

	Note.withId(this._id, this._title, this._date, this._priority, this._date1, [this._description]);

	int get id => _id;

	String get title => _title;

	String get description => _description;

	int get priority => _priority;

	String get date => _date;

	String get date1 => _date1;

	set title(String newTitle) {
		if (newTitle.length <= 255) {
			this._title = newTitle;
		}
	}

	set description(String newDescription) {
		if (newDescription.length <= 255) {
			this._description = newDescription;
		}
	}

	set priority(int newPriority) {
		if (newPriority >= 1 && newPriority <= 2) {
			this._priority = newPriority;
		}
	}

	set date(String newDate) {
		this._date = newDate;
	}

	set date1(String newDate1) {
		this._date1 = newDate1;
	}


	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['title'] = _title;
		map['description'] = _description;
		map['priority'] = _priority;
		map['date'] = _date;
		map['date1'] = _date1;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._priority = map['priority'];
		this._date = map['date'];
		this._date1 = map['date1'];
	}
}









