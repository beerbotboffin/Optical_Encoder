$r1 = 150
$r2 = $r1 + 10
segments = 8
 
# Create a 1/4 circle, normal to the Z axis
centre = Geom::Point3d.new
normal = Geom::Vector3d.new 0,0,1
xaxis = Geom::Vector3d.new 1,0,0
start_a = 0
end_a =  Math::PI * 2 / segments
# Math::PI * 2 /segments + start_a
model = Sketchup.active_model
entities = model.entities
edgearray = entities.add_arc centre, xaxis, normal, $r1/25.4, start_a, end_a, 80
edge = edgearray[0]
arccurve = edge.curve
end_angle = arccurve.end_angle
 
edgearray = entities.add_arc centre, xaxis, normal, $r2/25.4, start_a, end_a, 80
edge = edgearray[0]
arccurve = edge.curve

# Where h,k are the circle centre
# radius of the circle is radius
# start, end point of arc a,b-k
#
# cos(B) = (a-h)/r
# sin(B) = (b-k)/r
# Math.acos(B) = (end_a - 0) / $r1
# Math.atan2(-0.0, -1.0)
B = Math.acos(B) = (end_a , 0) / $r1

# $c = 0 + $r1/25.4 * Math.acos(B-A)
# $d = 0 + $r1/25.4 * Math.asin(B-A)

# Now create the closing lines at the end
# Line 1
point1 = Geom::Point3d.new($r1/25.4,0,0)
point2 = Geom::Point3d.new($r2/25.4,0,0)
line = entities.add_line point1,point2