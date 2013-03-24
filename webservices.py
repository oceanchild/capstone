import bottle
import mysql.connector
import datetime
import json

app = bottle.Bottle()

@app.route('/')
def push_test():
	''' Render testing page '''
	return bottle.static_file('webservices_push_test.html', './')

@app.post('/push')
def push():
	''' Establish connection '''
	conn = mysql.connector.connect(user='root', password='honker198874', host='127.0.0.1', database='capstone')
	cur = conn.cursor()

	''' Getting json from request '''
	json_obj = bottle.request.json
	# json_str = json.dumps(json_obj)
	print json_obj

	''' Submit patient monitoring data '''
	json_obj = json_obj['data'][0]
	fall_data_list = json_obj['fall_data']
	pulse_data_list = json_obj['pulse_data']
	blood_pressure_h = json_obj['blood_pressure_h']
	blood_pressure_l = json_obj['blood_pressure_l']
	battery_life = json_obj['battery_life']
	status_message = json_obj['status_message']

	next = True

	query = ('INSERT INTO monitored_status(patient_id, blood_pressure_h, blood_pressure_l, battery_life, status_message) VALUES(%s, %s, %s, %s, "%s")' % (str(172), blood_pressure_h, blood_pressure_l, battery_life, status_message))
	try:
		cur.execute(query)
	except:
		conn.rollback()
		next = False
		print 'Error: unable to insert data'

	entry_id = cur.lastrowid

	if next:
		for fd in fall_data_list:
			q = ('INSERT INTO fall_status(monitored_status_id, x_cord, y_cord, z_cord) VALUES(%s, %s, %s, %s)' % (entry_id, fd[0], fd[1], fd[2]))
			try:
				cur.execute(q)
			except:
				conn.rollback()
				next = False
				print 'Error: unable to insert data'
				break

	if next:
		for pd in pulse_data_list:
			q = ('INSERT INTO heart_rates(monitored_status_id, pulse) VALUES(%s, %s)' % (entry_id, pd))
			try:
				cur.execute(q)
				conn.commit() # save all previous changes
			except:
				conn.rollback()
				next = False
				print 'Error: unable to insert data'
	
	''' Close connection '''
	cur.close()
	conn.close()

	bottle.response.headers['Content-Type'] = 'application/json'
	return json_obj

@app.get('/pull/:patient_id')
def pull(patient_id):
	''' Establish connection '''
	conn = mysql.connector.connect(user='root', password='honker198874', host='127.0.0.1', database='capstone')
	cur = conn.cursor()

	''' Retrieve prescription schedule '''
	today = str(datetime.date(2013, 3, 28))
	json_obj = []
	query = ('SELECT id, pill_id, servings_per_day, quantities_per_serving, start_date, end_date FROM prescriptions WHERE patient_id = %s AND end_date >= "%s"' % (patient_id, today))
	try:
		cur.execute(query)
		prescriptions = cur.fetchall()
		for p in prescriptions:
			row = {'prescription_id': p[0], 'pill_id': p[1], 'servings_per_day': p[2], 'quantities_per_serving': p[3], 'start_date': str(p[4]), 'end_date': str(p[5])}
			json_obj.append(row)
		json_str = json.dumps(json_obj)
	except:
		print 'Error: unable to fetch data'

	''' Close connection '''
	cur.close()
	conn.close()

	bottle.response.headers['Content-Type'] = 'application/json'
	return json_str

if __name__ == '__main__':
	bottle.debug(True)
	bottle.run(app, host='localhost', port=8080, reloader=True)
