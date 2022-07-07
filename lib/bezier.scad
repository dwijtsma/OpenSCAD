
//create vector which start at A and ends at B in n+1 steps
//Needed for bezier calculation between A and C and B and C
function line_split(a,b,n) = [for(i=[0:n])
    [a[0]+i*(b[0]-a[0])/n, a[1]+i*(b[1]-a[1])/n]];
    
//Find the intersection of two lines.
//Inputs are vectors for each line. For example: [[0,0][10,10]]
//Thanks to: https://en.wikipedia.org/wiki/Line-line_intersection
function intersect(L1,L2) = 
    //Check denominator d to make sure lines intersect.
    assert((L1[0][0]-L1[1][0])*(L2[0][1]-L2[1][1])-
           (L1[0][1]-L1[1][1])*(L2[0][0]-L2[1][0])!=0,
           "lines don't intersect. C in line with A and B?")

    let(
        //Split line vectors into 4 seperate points
        x1=L1[0][0],    x2=L1[1][0],    y1=L1[0][1],    y2=L1[1][1],
        x3=L2[0][0],    x4=L2[1][0],    y3=L2[0][1],    y4=L2[1][1],
        d = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4),
        x = ((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4))/d,
        y = ((x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4))/d)
    [x,y];

//quadratic bezier
function quadratic_bezier(a,b,c,n) =
    let(
        va = line_split(a=a,b=c,n=n),
        vb = line_split(a=b,b=c,n=n),
        lines = [for(i=[0:n]) [va[i],vb[n-i]] ],
        curve = [for(i=[0:n-1]) intersect(lines[i],lines[i+1])])
    concat([va[0],for(i=[0:n-1]) curve[i],vb[0]]);

//cubic bezier
function cubic_bezier(a,b,c,d,n) =
    let(
        va = line_split(a=a,b=b,n=n),
        vb = line_split(a=b,b=c,n=n),
        vc = line_split(a=c,b=d,n=n),
        lines_ab = [for(i=[0:n]) line_split(a=va[i],b=vb[i],n=n)],
        lines_bc = [for(i=[0:n]) line_split(a=vb[i],b=vc[i],n=n)],
        lines    = [for(i=[0:n]) line_split(a=lines_ab[i][i],b=lines_bc[i][i],n=n)[i]])
    lines;

//---------------------quadratic_bezier---------------------
a=[ 5, -5];
b=[20, 5];
c=[-5,5];
n=20;

translate([0,30,0]) {
    polygon(quadratic_bezier(a=a,b=b,c=c,n=n));

    color("red") translate(a) circle(d=1, $fn=10);
    color("red") translate(b) circle(d=1, $fn=10);
    color("red") translate(c) circle(d=1, $fn=10);

    translate(a)
    rotate([0,0,-atan((c[0]-a[0])/(c[1]-a[1]))+((c[1]-a[1])<0?180:0)])
    color("red") square([0.1,sqrt((c[0]-a[0])^2+(c[1]-a[1])^2)]);

    translate(b)
    rotate([0,0,-atan((c[0]-b[0])/(c[1]-b[1]))+((c[1]-b[1])<0?180:0)])
    color("red") square([0.1,sqrt((c[0]-b[0])^2+(c[1]-b[1])^2)]);
}

//-----------------------cubic_bezier-----------------------
p0=[-5,5];
p1=[20,20];
p2=[20,10];
p3=[15,2];

polygon(cubic_bezier(a=p0,b=p1,c=p2,d=p3,n=50));

color("red") translate(p0) circle(d=1, $fn=10);
color("red") translate(p1) circle(d=1, $fn=10);
color("red") translate(p2) circle(d=1, $fn=10);
color("red") translate(p3) circle(d=1, $fn=10);

translate(p0)
rotate([0,0,-atan((p1[0]-p0[0])/(p1[1]-p0[1]))+((p1[1]-p0[1])<0?180:0)])
color("red") square([0.1,sqrt((p1[0]-p0[0])^2+(p1[1]-p0[1])^2)]);

translate(p3)
rotate([0,0,-atan((p3[0]-p2[0])/(p3[1]-p2[1]))+((p3[1]-p2[1])>0?180:0)])
color("red") square([0.1,sqrt((p3[0]-p2[0])^2+(p3[1]-p2[1])^2)]);
