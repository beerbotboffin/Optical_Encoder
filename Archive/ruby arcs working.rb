# This script will create the layout for my absolute rotary encoder
# Written by Shane Frost
#
# Begin by declaring the variables
ring = 1
rings = 12
$r1 = 150
segments = 2
facets = 60

# Loop through the rings.
while ring < rings do
	
	#Increment the radius by 10mm and reset the segment back to the first
	$r2 = $r1 + 10
	segment = 0
	
	#Loop through the segments of the ring
	while segment < segments do
		# Create an segment arc, normal to the Z axis
		centre = Geom::Point3d.new
		normal = Geom::Vector3d.new 0,0,1
		xaxis = Geom::Vector3d.new 1,0,0
		start_a = Math::PI * 2 / segments * segment
		end_a =  Math::PI * 2 / segments * (segment +1)
		model = Sketchup.active_model
		entities = model.entities
		edgearray = entities.add_arc centre, xaxis, normal, $r1/25.4, start_a, end_a, facets
		edge = edgearray[0]
		arccurve = edge.curve
		end_angle = arccurve.end_angle
		 
		edgearray = entities.add_arc centre, xaxis, normal, $r2/25.4, start_a, end_a, facets
		edge = edgearray[0]
		arccurve = edge.curve
		segment += 2
	end
	
	# Now increment the required variables before moving to the next ring.
	ring += 1
	$r1 += 10
	#UI.messagebox(segments)
	segments += segments
	facets -= 10
end