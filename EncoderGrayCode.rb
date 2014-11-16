	require 'win32ole'

	########################################################################
	#
	# This script will create the layout for my absolute rotary encoder
	# This will be used in the construction of my telescope.
	# Written by Shane Frost
	# 13 Nov 2014
	#
	# TODO
	# Add gray code
	# Add options
	# Add mounting tabs
	#
	# Thanks to jim_foltz, TIG & slbaumgartner from the Sketchup Forums.
	#
	########################################################################
	
	module MAKEFACE
		# This code is from TOG @ Sketchup Forums.
		# Full credit for this module to TIG.
		# Thanks TIG!
		def self.arcface(ents=nil, cent=ORIGIN, axis=X_AXIS, norm=Z_AXIS, rad1=1.0, rad2=2.0, stara=0.0, enda=180.degrees, fac = 30)
			ents=Sketchup.active_model.active_entities unless ents
			grop=ents.add_group()
			ents=grop.entities
			arc1=ents.add_arc(cent, axis, norm, rad1, stara, enda, fac+10)
			arc2=ents.add_arc(cent, axis, norm, rad2, stara, enda, fac+10)
			vx10=arc1[0].start
			vx20=arc2[0].start
			edg1=ents.add_line(vx10, vx20)
			vx12=arc1[-1].end
			vx22=arc2[-1].end
			edg2=ents.add_line(vx12, vx22)
			edg2.find_faces
			face=ents.grep(Sketchup::Face)
			grop.explode
			return face
		end
	end

	##################################################################
	def inputbox( message, title="Message from #{__FILE__}" )
	vb_msg = %Q| "#{message.gsub("\n",'"& vbcrlf &"')}"|
	vb_msg.gsub!( "\t", '"& vbtab &"' )
	vb_msg.gsub!( '&""&','&' )
	vb_title = %Q|"#{title}"|
	# go!
	
	sc = WIN32OLE.new("ScriptControl")
	sc.language = "VBScript"
	sc.eval(%Q|Inputbox(#{vb_msg}, #{vb_title})|)
	#~ sc.eval(%Q|Inputbox(#{vb_msg}, #{vb_title}, aa,hide)|)
	end
	def popup(message)
	wsh = WIN32OLE.new('WScript.Shell')
	wsh.popup(message, 0, __FILE__)
	end
	
	##################################################################
	# Prompt the use for the variables.
	str = "Enter number of bits"
	result = inputbox( str, "Optical Encoder Generator")
	rings = result.gsub(/[^0-9\.]/,'').to_f #Cast the result to float
	#popup %Q|When asked\n\n"#{str}"\n\nyou answered:\n#{res}| 
	

	##################################################################
	# Declare the constants
	ring = 1
	#rings = 6
	$r1 = 200
	segments = 2.0
	x = 0
	y = 0

	##################################################################
	# Add Inner circle
	centre_point = Geom::Point3d.new(x,y,0)
	normal_vector = Geom::Vector3d.new(x,y,1)
	entities = Sketchup.active_model.entities
	edgearray = entities.add_circle centre_point, normal_vector, $r1/25.4, 360
	first_edge = edgearray[0]
	arccurve = first_edge.curve
	
	##################################################################
	# Add the mounting points
	seg = 144
	centre = Geom::Point3d.new
	normal = Geom::Vector3d.new 0,0,1
	xaxis = Geom::Vector3d.new 1,0,0
	# Mount point 1 ###########
	start_a = 0.0 
	end_a =  0.2 
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+5)/25.4, start_a, end_a, 360/segments
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+10)/25.4, start_a, end_a, 360/segments
	# Mount point 2 ###########
	start_a = Math::PI*2/3*2 
	end_a =  Math::PI*2/3*2+0.2 
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+5)/25.4, start_a, end_a, 360/segments
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+10)/25.4, start_a, end_a, 360/segments
	# Mount point 3 ###########
	start_a = Math::PI*2/3 
	end_a =  Math::PI*2/3+0.2 
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+5)/25.4, start_a, end_a, 360/segments
	edgearray = entities.add_arc centre, xaxis, normal, ($r1+10)/25.4, start_a, end_a, 360/segments

	########################################
	# Start of Mount points ###########
	topa = Math::PI
	bota = Math::PI*2
	centre_point = Geom::Point3d.new(($r1+7.5)/25.4,0,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, topa, bota, 30

	topa = 60*(Math::PI/180)
	bota = 2*Math::PI-(120*(Math::PI/180))
	centre_point = Geom::Point3d.new(Math.cos((Math::PI*2/3)*2)*($r1+7.5)/25.4,Math.sin(Math::PI*2/3*2)*($r1+7.5)/25.4,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, bota,topa, 30
	
	xaxis = Geom::Vector3d.new -1,0,0
	topa = 2*Math::PI - (60*(Math::PI/180))
	bota = 120*(Math::PI/180)
	centre_point = Geom::Point3d.new(Math.cos(Math::PI*2/3*2)*($r1+7.5)/25.4,-Math.sin(Math::PI*2/3*2)*($r1+7.5)/25.4,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, bota, topa, 30	
	
	########################################
	# End of Mount points ###########
	xaxis = Geom::Vector3d.new 1,0,0
	topa = 0.2
	bota = Math::PI+0.2
	centre_point = Geom::Point3d.new(Math.cos(0.2)*($r1+7.5)/25.4,Math.sin(0.2)*($r1+7.5)/25.4,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, topa, bota, 30
	
	xaxis = Geom::Vector3d.new -1,0,0
	topa = 2*Math::PI - (108.5*(Math::PI/180))
	bota = 71.5*(Math::PI/180)
	centre_point = Geom::Point3d.new(Math.cos(Math::PI*2/3*2+0.2)*($r1+7.5)/25.4,Math.sin(Math::PI*2/3*2+0.2)*($r1+7.5)/25.4,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, topa, bota, 30
	
	xaxis = Geom::Vector3d.new 1,0,0
	topa = Math::PI-(48.5*(Math::PI/180))
	bota = Math::PI+(138.5*(Math::PI/180))
	centre_point = Geom::Point3d.new(Math.cos(Math::PI*2/3*2-0.2)*($r1+7.5)/25.4,-Math.sin(Math::PI*2/3*2-0.2)*($r1+7.5)/25.4,0)
	model = Sketchup.active_model
	entities = model.entities
	edgearray = entities.add_arc centre_point, xaxis, normal, 2.5/25.4, topa, bota, 30	

	
	$r1 +=20

	# Loop through the rings.
	while ring < rings + 1 do
		
		#Increment the radius by 10mm and reset the segment back to the first
		$r2 = $r1 + 10
		segment = 0
		AngleVal = 360.0 / segments
		
		#Loop through the segments of the ring
		while segment < segments do
			# Create an segment arc, normal to the Z axis
			centre = Geom::Point3d.new
			normal = Geom::Vector3d.new 0,0,1
			xaxis = Geom::Vector3d.new 1,0,0
			start_a = Math::PI*2/segments*segment
			end_a =  Math::PI*2/segments*(segment+1)
			model = Sketchup.active_model
			entities = model.entities
			edgearray = entities.add_arc centre, xaxis, normal, $r1/25.4, start_a, end_a, 360/segments
			edge = edgearray[0]
			arccurve = edge.curve
			end_angle = arccurve.end_angle

			##################################################################
			edgearray = entities.add_arc centre, xaxis, normal, $r2/25.4, start_a, end_a, 360/segments
			edge = edgearray[0]
			arccurve = edge.curve
			
			##################################################################
			# Now create the closing lines at the start of arc
			point1 = Geom::Point3d.new(Math.cos(((360.0/segments)*(segment))*(Math::PI/180))*$r2/25.4,Math.sin(((360.0/segments)*(segment))*(Math::PI/180))*$r2/25.4,0) # Outer arc
			point2 = Geom::Point3d.new(Math.cos(((360.0/segments)*(segment))*(Math::PI/180))*$r1/25.4,Math.sin(((360.0/segments)*(segment))*(Math::PI/180))*$r1/25.4,0) # Inner arc
			line = entities.add_line point1,point2
			##################################################################
			# Now create the closing lines at the end of arc
			point1 = Geom::Point3d.new(Math.cos(((360.0/segments)*(segment+1))*(Math::PI/180))*$r2/25.4,Math.sin(((360.0/segments)*(segment+1))*(Math::PI/180))*$r2/25.4,0) # Outer arc
			point2 = Geom::Point3d.new(Math.cos(((360.0/segments)*(segment+1))*(Math::PI/180))*$r1/25.4,Math.sin(((360.0/segments)*(segment+1))*(Math::PI/180))*$r1/25.4,0) # Inner arc
			line = entities.add_line point1,point2
			
			##################################################################
			# Find the faces
			# Thanks to TIG & slbaumgartner from Sketchup Forums!	
			MAKEFACE.arcface(ents=nil, cent=ORIGIN, axis=X_AXIS, norm=Z_AXIS, rad1=$r1/25.4, rad2=$r2/25.4, stara=start_a, enda=end_a, 360/segments)
			
			segment += 2 #Increment the segment
		end
		
		# Now increment the required variables before moving to the next ring.
		ring += 1
		$r1 += 10
		segments += segments
	end

	##################################################################
	# Close the outside of the disc.
	centre_point = Geom::Point3d.new(x,y,0)
	normal_vector = Geom::Vector3d.new(x,y,1)
	radius = $r2 / 25.4
	entities = Sketchup.active_model.entities
	edgearray = entities.add_circle centre_point, normal_vector, radius, 360
	first_edge = edgearray[0]
	arccurve = first_edge.curve