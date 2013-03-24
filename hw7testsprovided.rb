# University of Washington, Programming Languages, Homework 7,
# hw7testsprovided.rb

require "./hw7.rb"

#  Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
EIGHT = 8.0
NINE = 9.0
TEN = 10.0

#Point Tests
a = Point.new(THREE,FIVE)
if not (a.x == THREE and a.y == FIVE)
    puts "Point is not initialized properly"
end
if not (a.eval_prog([]) == a)
    puts "Point eval_prog should return self"
end
if not (a.preprocess_prog == a)
    puts "Point preprocess_prog should return self"
end
a1 = a.shift(THREE,FIVE)
if not (a1.x == SIX and a1.y == TEN)
    puts "Point shift not working properly"
end
a2 = a.intersect(Point.new(THREE,FIVE))
if not (a2.x == THREE and a2.y == FIVE)
    puts "Point intersect not working properly"
end
a3 = a.intersect(Point.new(FOUR,FIVE))
if not (a3.is_a? NoPoints)
    puts "Point intersect not working properly"
end

#Line Tests
b = Line.new(THREE,FIVE)
if not (b.m == THREE and b.b == FIVE)
    puts "Line not initialized properly"
end
if not (b.eval_prog([]) == b)
    puts "Line eval_prog should return self"
end
if not (b.preprocess_prog == b)
    puts "Line preprocess_prog should return self"
end

b1 = b.shift(THREE,FIVE)
if not (b1.m == THREE and b1.b == ONE)
    puts "Line shift not working properly"
end

b2 = b.intersect(Line.new(THREE,FIVE))
if not (((b2.is_a? Line)) and b2.m == THREE and b2.b == FIVE)
    puts "Line intersect not working properly"
end
b3 = b.intersect(Line.new(THREE,FOUR))
if not ((b3.is_a? NoPoints))
    puts "Line intersect not working properly"
end

#VerticalLine Tests
c = VerticalLine.new(THREE)
if not (c.x == THREE)
    puts "VerticalLine not initialized properly"
end

if not (c.eval_prog([]) == c)
    puts "VerticalLine eval_prog should return self"
end
if not (c.preprocess_prog == c)
    puts "VerticalLine preprocess_prog should return self"
end
c1 = c.shift(THREE,FIVE)
if not (c1.x == SIX)
    puts "VerticalLine shift not working properly"
end
c2 = c.intersect(VerticalLine.new(THREE))
if not ((c2.is_a? VerticalLine) and c2.x == THREE )
    puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(VerticalLine.new(FOUR))
if not ((c3.is_a? NoPoints))
    puts "VerticalLine intersect not working properly"
end

#LineSegment Tests
d = LineSegment.new(ONE,TWO,-THREE,-FOUR)
if not (d.eval_prog([]) == d)
    puts "LineSegement eval_prog should return self"
end
d1 = LineSegment.new(ONE,TWO,ONE,TWO)
d2 = d1.preprocess_prog
if not ((d2.is_a? Point)and d2.x == ONE and d2.y == TWO)
    puts "LineSegment preprocess_prog should convert to a Point"
    puts "if ends of segment are real_close"
end

d = d.preprocess_prog
if not (d.x1 == -THREE and d.y1 == -FOUR and d.x2 == ONE and d.y2 == TWO)
    puts "LineSegment preprocess_prog should make x1 and y1"
    puts "on the left of x2 and y2"
end

d3 = d.shift(THREE,FIVE)
if not (d3.x1 == ZERO and d3.y1 == ONE and d3.x2 == FOUR and d3.y2 == SEVEN)
    puts "LineSegment shift not working properly"
end

d4 = d.intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
if not (((d4.is_a? LineSegment)) and d4.x1 == -THREE and d4.y1 == -FOUR and d4.x2 == ONE and d4.y2 == TWO)
    puts "LineSegment intersect not working properly"
end
d5 = d.intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))
if not ((d5.is_a? NoPoints))
    puts "LineSegment intersect not working properly"
end

#Intersect Tests
i = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
i1 = i.preprocess_prog.eval_prog([])
if not (i1.x1 == -ONE and i1.y1 == -TWO and i1.x2 == THREE and i1.y2 == FOUR)
    puts "Intersect eval_prog should return the intersect between e1 and e2"
end

#Var Tests
v = Var.new("a")
v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])
if not ((v1.is_a? Point) and v1.x == THREE and v1.y == FIVE)
    puts "Var eval_prog is not working properly"
end
if not (v1.preprocess_prog == v1)
    puts "Var preprocess_prog should return self"
end

#Let Tests
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR),
             Intersect.new(Var.new("a"),LineSegment.new(THREE,FOUR,-ONE,-TWO)))
l1 = l.preprocess_prog.eval_prog([])
if not (l1.x1 == -ONE and l1.y1 == -TWO and l1.x2 == THREE and l1.y2 == FOUR)
    puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end

#Let Variable Shadowing Test
l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
              Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO), Intersect.new(Var.new("a"),Var.new("b"))))
l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])
if not (l2.x1 == -ONE and l2.y1 == -TWO and l2.x2 == THREE and l2.y2 == FOUR)
    puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end


#Shift Tests
s = Shift.new(THREE,FIVE,LineSegment.new(-ONE,-TWO,THREE,FOUR))
s1 = s.preprocess_prog.eval_prog([])
if not (s1.x1 == TWO and s1.y1 == THREE and s1.x2 == SIX and s1.y2 == 9)
    puts "Shift should shift e by dx and dy"
end


# adaptation from https://class.coursera.org/proglang-2012-001/forum/thread?thread_id=3479
class GeometryExpression
    def real_close(r1,r2)
        (r1 - r2).abs < GeometryExpression::Epsilon
    end
    def real_close_point(x1,y1,x2,y2)
        real_close(x1,x2) && real_close(y1,y2)
    end
end

class NoPoints < GeometryValue
  def ==(np)
    self.class == np.class
  end
end

class Point < GeometryValue
  def ==(p)
    self.class == p.class and real_close_point(@x, @y, p.x, p.y)
  end
end

class Line < GeometryValue
  def ==(l)
    self.class == l.class and real_close_point(@m, @b, l.m, l.b)
  end
end

class VerticalLine < GeometryValue
  def ==(vl)
    self.class == vl.class and real_close(@x, vl.x)
  end
end

class LineSegment < GeometryValue
  def ==(ls)
    self.class == ls.class and
    real_close_point(@x1,@y1,ls.x1,ls.y1) and
    real_close_point(@x2,@y2,ls.x2,ls.y2)
  end
end

class Intersect < GeometryExpression
  attr_reader :e1, :e2
  def ==(i)
    self.class == i.class and @e1 == i.e1 and @e2 == i.e2
  end
end

class Let < GeometryExpression
  attr_reader :s, :e1, :e2
  def ==(l)
    self.class == l.class and @s == l.s and @e1 == l.e1 and @e2 == l.e2
  end
end

class Var < GeometryExpression
  attr_reader :s
  def ==(v)
    self.class == v.class and @s == v.s
  end
end

class Shift < GeometryExpression
  attr_reader :dx, :dy, :e
  def ==(s)
    self.class == s.class and real_close_point(@dx, @dy, s.dx, s.dy) and @e == s.e
  end
end

def equal(e1, e2)
    e1 == e2
end

tests = []
tests[0] = equal(NoPoints.new.preprocess_prog, NoPoints.new)
tests[1] = equal(Point.new(ONE, ONE).preprocess_prog, Point.new(ONE, ONE))
tests[2] = equal(Line.new(ONE, TWO).preprocess_prog, Line.new(ONE, TWO))
tests[3] = equal(VerticalLine.new(TWO).preprocess_prog, VerticalLine.new(TWO))
tests[4] = equal(LineSegment.new(ONE, ONE, ONE, ONE).preprocess_prog, Point.new(ONE, ONE))
tests[5] = equal(LineSegment.new(ONE, ONE, ONE, TWO).preprocess_prog, LineSegment.new(ONE, ONE, ONE, TWO))
tests[6] = equal(LineSegment.new(ONE, ONE, ONE, ZERO).preprocess_prog, LineSegment.new(ONE, ZERO, ONE, ONE))
tests[7] = equal(LineSegment.new(ONE, ONE, TWO, ONE).preprocess_prog, LineSegment.new(ONE, ONE, TWO, ONE))
tests[8] = equal(LineSegment.new(ONE, ZERO, TWO, ONE).preprocess_prog, LineSegment.new(ONE, ZERO, TWO, ONE))
tests[9] = equal(LineSegment.new(ONE, ONE, TWO, ZERO).preprocess_prog, LineSegment.new(ONE, ONE, TWO, ZERO))
tests[10] = equal(LineSegment.new(TWO, ONE, ONE, ONE).preprocess_prog, LineSegment.new(ONE, ONE, TWO, ONE))
tests[11] = equal(LineSegment.new(TWO, ZERO, ONE, ONE).preprocess_prog, LineSegment.new(ONE, ONE, TWO, ZERO))
tests[12] = equal(LineSegment.new(TWO, ONE, ONE, ZERO).preprocess_prog, LineSegment.new(ONE, ZERO, TWO, ONE))
tests[13] = equal(LineSegment.new(1.00000999, ONE, ONE, TWO).preprocess_prog, LineSegment.new(1.00000999, ONE, ONE, TWO))
tests[14] = equal(Let.new("x", LineSegment.new(ONE, ONE, ONE, ONE), Var.new("x")).preprocess_prog, Let.new("x", Point.new(ONE, ONE), Var.new("x")))
tests[15] = equal(Shift.new(ONE, ONE, LineSegment.new(ONE, ONE, ONE, ONE)).preprocess_prog, Shift.new(ONE, ONE, Point.new(ONE, ONE)))
tests[16] = equal(Intersect.new(LineSegment.new(ONE, ONE, ONE, ONE), LineSegment.new(TWO, ONE, ONE, ZERO)).preprocess_prog, Intersect.new(Point.new(ONE, ONE), LineSegment.new(ONE, ZERO, TWO, ONE)))
tests[17] = equal(Shift.new(ONE, ONE, Intersect.new(LineSegment.new(ONE, ONE, ONE, ONE), LineSegment.new(TWO, ONE, ONE, ZERO))).preprocess_prog, Shift.new(ONE, ONE, Intersect.new(Point.new(ONE, ONE), LineSegment.new(ONE, ZERO, TWO, ONE))))
tests[81] = Shift.new(ONE, TWO, LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Shift.new(ONE, TWO, Point.new(3.2, 4.1))
tests[80] = Let.new("a", LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Let.new("a", Point.new(3.2, 4.1), Point.new(3.2, 4.1))
tests[82] = Intersect.new(LineSegment.new(3.2,4.1,3.2,4.1), LineSegment.new(3.2,4.1,3.2,4.1)).preprocess_prog == Intersect.new(Point.new(3.2, 4.1), Point.new(3.2, 4.1))

# eval_prog
# Shift
tests[20] = equal(Shift.new(ONE, ONE, Point.new(TWO, THREE)).eval_prog([]), Point.new(THREE, FOUR))
tests[21] = equal(Shift.new(TWO, 10.3, Line.new(THREE, FIVE)).eval_prog([]), Line.new(THREE, 9.3))
tests[22] = equal(Shift.new(ONE, TWO, VerticalLine.new(FIVE)).eval_prog([]), VerticalLine.new(6.0))
tests[23] = equal(Shift.new(TWO, TWO, LineSegment.new(ONE, ONE, ONE, ONE)).preprocess_prog.eval_prog([]), Point.new(THREE, THREE))
tests[24] = equal(Shift.new(ONE, TWO, LineSegment.new(ONE, ONE, THREE, THREE)).preprocess_prog.eval_prog([]), LineSegment.new(TWO, THREE, FOUR, FIVE))
tests[25] = equal(Shift.new(ONE, ONE, Shift.new(ONE, ONE, Shift.new(ONE, ONE, Point.new(ONE, ONE)))).preprocess_prog.eval_prog([]), Point.new(FOUR, FOUR))
tests[83] = Shift.new(THREE, FOUR, Point.new(FOUR, FOUR)).eval_prog([]) == Point.new(SEVEN, EIGHT)
tests[84] = Shift.new(THREE, FOUR, Line.new(FOUR, FOUR)).eval_prog([]) == Line.new(FOUR, -FOUR)
tests[85] = Shift.new(THREE, FOUR, VerticalLine.new(FOUR)).eval_prog([]) == VerticalLine.new(SEVEN)
tests[86] = Shift.new(THREE, FOUR, LineSegment.new(FOUR, THREE, 12.0, -TWO)).eval_prog([]) == LineSegment.new(SEVEN, SEVEN, 15.0, TWO)

# Let
tests[31] = equal(Let.new("x", Point.new(TWO, THREE), Var.new("x")).preprocess_prog.eval_prog([]), Point.new(TWO, THREE))
tests[32] = equal(Let.new("x", Line.new(THREE, FIVE), Var.new("x")).preprocess_prog.eval_prog([]), Line.new(THREE, FIVE))
tests[33] = equal(Let.new("x", VerticalLine.new(ONE), Var.new("x")).preprocess_prog.eval_prog([]), VerticalLine.new(ONE))
tests[34] = equal(Let.new("x", LineSegment.new(TWO, TWO, ONE, ONE), Var.new("x")).preprocess_prog.eval_prog([]), LineSegment.new(ONE, ONE, TWO, TWO))
tests[35] = equal(Let.new("x", Point.new(ONE, ONE), Let.new("x", Point.new(TWO, TWO), Var.new("x"))).preprocess_prog.eval_prog([]), Point.new(TWO, TWO))

# Let + Shift
tests[40] = equal(Let.new("x", LineSegment.new(ONE, ONE, ONE, ONE), Shift.new(ONE, ONE, Var.new("x"))).preprocess_prog.eval_prog([]), Point.new(TWO, TWO))
tests[41] = equal(Shift.new(ONE, ONE, Let.new("x", VerticalLine.new(TWO), Var.new("x"))).preprocess_prog.eval_prog([]), VerticalLine.new(THREE))

# Intersect
# NoPoints
tests[45] = equal(Intersect.new(NoPoints.new, NoPoints.new).preprocess_prog.eval_prog([]), NoPoints.new)
tests[46] = equal(Intersect.new(NoPoints.new, Point.new(ONE, TWO)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[47] = equal(Intersect.new(NoPoints.new, Line.new(ONE, ONE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[48] = equal(Intersect.new(NoPoints.new, VerticalLine.new(ONE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[49] = equal(Intersect.new(NoPoints.new, LineSegment.new(ONE, ONE, THREE, THREE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[50] = equal(Intersect.new(Point.new(ONE, ONE), Point.new(1.00000999, ONE)).preprocess_prog.eval_prog([]), Point.new(1.00000999, ONE))
tests[51] = equal(Intersect.new(Point.new(ONE, ONE), Point.new(1.0999, ONE)).preprocess_prog.eval_prog([]), NoPoints.new)

# Point
tests[52] = equal(Intersect.new(Point.new(ONE, FOUR), Line.new(ONE, THREE)).preprocess_prog.eval_prog([]), Point.new(ONE, FOUR))
tests[53] = equal(Intersect.new(Point.new(TWO, FOUR), Line.new(ONE, THREE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[54] = equal(Intersect.new(Point.new(TWO, FOUR), VerticalLine.new(TWO)).preprocess_prog.eval_prog([]), Point.new(TWO, FOUR))
tests[55] = equal(Intersect.new(Point.new(FOUR, FOUR), VerticalLine.new(TWO)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[56] = equal(Intersect.new(Point.new(TWO, TWO), LineSegment.new(ZERO, ZERO, THREE, THREE)).preprocess_prog.eval_prog([]), Point.new(TWO, TWO))
tests[57] = equal(Intersect.new(Point.new(FOUR, FOUR), LineSegment.new(ZERO, ZERO, THREE, THREE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[87] = Intersect.new(Point.new(FOUR, FOUR), Point.new(FOUR, FOUR)).eval_prog([]) == Point.new(FOUR, FOUR)
tests[88] = Intersect.new(Point.new(FOUR, FOUR), Point.new(FOUR, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[89] = Intersect.new(Point.new(FOUR, FOUR), Line.new(FOUR, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[90] = Intersect.new(Point.new(ONE, EIGHT), Line.new(FOUR, FOUR)).eval_prog([]) == Point.new(ONE, EIGHT)
tests[91] = Intersect.new(Point.new(FIVE, FOUR), VerticalLine.new(FOUR)).eval_prog([]).class == NoPoints.new.class
tests[92] = Intersect.new(Point.new(FOUR, FOUR), VerticalLine.new(FOUR)).eval_prog([]) == Point.new(FOUR, FOUR)
tests[93] = Intersect.new(Point.new(TWO, TWO), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]) == Point.new(TWO, TWO)
tests[94] = Intersect.new(Point.new(4.1, 4.1), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]).class == NoPoints.new.class

# Line
tests[58] = equal(Intersect.new(Line.new(ONE, TWO), Line.new(TWO, ZERO)).preprocess_prog.eval_prog([]), Point.new(TWO, FOUR))
tests[59] = equal(Intersect.new(Line.new(ONE, TWO), Line.new(ONE, THREE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[60] = equal(Intersect.new(Line.new(ONE, TWO), VerticalLine.new(TWO)).preprocess_prog.eval_prog([]), Point.new(TWO, FOUR))
tests[61] = equal(Intersect.new(Line.new(ONE, ZERO), LineSegment.new(ZERO, ZERO, FOUR, FOUR)).preprocess_prog.eval_prog([]), LineSegment.new(ZERO, ZERO, FOUR, FOUR))
tests[62] = equal(Intersect.new(Line.new(TWO, ZERO), LineSegment.new(ZERO, ZERO, FOUR, FOUR)).preprocess_prog.eval_prog([]), Point.new(ZERO, ZERO))
tests[63] = equal(Intersect.new(Line.new(TWO, ZERO), LineSegment.new(ONE, ONE, FOUR, FOUR)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[95] = Intersect.new(Line.new(FOUR, FOUR), Point.new(ONE, EIGHT)).eval_prog([]) == Point.new(ONE, EIGHT)
tests[96] = Intersect.new(Line.new(FOUR, FOUR), Point.new(FOUR, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[97] = Intersect.new(Line.new(FOUR, FOUR), Line.new(FOUR, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[98] = Intersect.new(Line.new(ONE, SEVEN), Line.new(FOUR, FOUR)).eval_prog([]) == Point.new(ONE, EIGHT)
tests[99] = Intersect.new(Line.new(FOUR, FOUR), VerticalLine.new(FOUR)).eval_prog([]) == Point.new(FOUR, 20.0)
tests[100] = Intersect.new(Line.new(-ONE, ONE), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]).class == NoPoints.new.class
tests[101] = Intersect.new(Line.new(-ONE, TWO), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]) == Point.new(ONE, ONE)

# VerticalLine
tests[64] = equal(Intersect.new(VerticalLine.new(ONE), VerticalLine.new(TWO)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[65] = equal(Intersect.new(VerticalLine.new(ONE), LineSegment.new(ONE, ZERO, ONE, FOUR)).preprocess_prog.eval_prog([]), LineSegment.new(ONE, ZERO, ONE, FOUR))
tests[66] = equal(Intersect.new(VerticalLine.new(ONE), LineSegment.new(ZERO, ONE, THREE, ONE)).preprocess_prog.eval_prog([]), Point.new(ONE, ONE))
tests[67] = equal(Intersect.new(VerticalLine.new(ONE), LineSegment.new(TWO, TWO, FOUR, FOUR)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[102] = Intersect.new(VerticalLine.new(FOUR), Point.new(FOUR, EIGHT)).eval_prog([]) == Point.new(FOUR, EIGHT)
tests[103] = Intersect.new(VerticalLine.new(FOUR), Point.new(4.1, FOUR)).eval_prog([]).class == NoPoints.new.class
tests[104] = Intersect.new(VerticalLine.new(FOUR), Line.new(FOUR, FOUR)).eval_prog([]) == Point.new(FOUR, 20.0)
tests[105] = Intersect.new(VerticalLine.new(FOUR), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class
tests[106] = Intersect.new(VerticalLine.new(FOUR), VerticalLine.new(FOUR)).eval_prog([]) == VerticalLine.new(FOUR)
tests[107] = Intersect.new(VerticalLine.new(4.1), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]).class == NoPoints.new.class
tests[108] = Intersect.new(VerticalLine.new(TWO), LineSegment.new(ONE, ONE, FOUR, FOUR)).eval_prog([]) == Point.new(TWO, TWO)

# LineSegment
tests[70] = equal(Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, FOUR), LineSegment.new(ONE, ZERO, ONE, FOUR)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[71] = equal(Intersect.new(LineSegment.new(ZERO, ZERO, FOUR, ZERO), LineSegment.new(ZERO, ONE, FOUR, ONE)).preprocess_prog.eval_prog([]), NoPoints.new)
tests[72] = equal(Intersect.new(LineSegment.new(TWO, ZERO, TWO, FOUR), LineSegment.new(ZERO, TWO, FOUR, TWO)).preprocess_prog.eval_prog([]), Point.new(TWO, TWO))
tests[73] = equal(Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, FOUR), LineSegment.new(ZERO, ONE, ZERO, THREE)).preprocess_prog.eval_prog([]), LineSegment.new(ZERO, ONE, ZERO, THREE))
tests[74] = equal(Intersect.new(LineSegment.new(ZERO, ONE, ZERO, THREE), LineSegment.new(ZERO, ZERO, ZERO, FOUR)).preprocess_prog.eval_prog([]), LineSegment.new(ZERO, ONE, ZERO, THREE))
tests[75] = equal(Intersect.new(LineSegment.new(ZERO, ONE, ZERO, THREE), LineSegment.new(ZERO, ONE, ZERO, THREE)).preprocess_prog.eval_prog([]), LineSegment.new(ZERO, ONE, ZERO, THREE))
tests[76] = equal(Intersect.new(LineSegment.new(ZERO, ZERO, ZERO, THREE), LineSegment.new(ZERO, ONE, ZERO, FOUR)).preprocess_prog.eval_prog([]), LineSegment.new(ZERO, ONE, ZERO, THREE))

# Intersection tests with LineSegment and Point/Line/VerticalLine
tests[109] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Point.new(TWO, TWO)).eval_prog([]) == Point.new(TWO, TWO)
tests[110] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Point.new(4.1, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[111] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Line.new(-ONE, ONE)).eval_prog([]).class == NoPoints.new.class
tests[112] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), Line.new(-ONE, TWO)).eval_prog([]) == Point.new(ONE, ONE)
tests[113] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class
tests[114] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), VerticalLine.new(TWO)).eval_prog([]) == Point.new(TWO, TWO)

# Intersection between a vertical LineSegment and Point/Line/VerticalLine
tests[115] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), Point.new(ONE, TWO)).eval_prog([]) == Point.new(ONE, TWO)
tests[116] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), Point.new(ONE, 4.1)).eval_prog([]).class == NoPoints.new.class
tests[117] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), Line.new(-ONE, ONE)).eval_prog([]).class == NoPoints.new.class
tests[118] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), Line.new(-ONE, FOUR)).eval_prog([]) == Point.new(ONE, THREE)
tests[119] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), VerticalLine.new(4.1)).eval_prog([]).class == NoPoints.new.class
tests[120] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), VerticalLine.new(ONE)).eval_prog([]) == LineSegment.new(ONE, ONE, ONE, FOUR)

# intersection between two oblique LineSegments
tests[121] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(4.1, 4.1, FIVE, FIVE)).eval_prog([]).class == NoPoints.new.class
tests[122] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(TWO, TWO, THREE, THREE)).eval_prog([]) == LineSegment.new(TWO, TWO, THREE, THREE)
tests[123] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(-ONE, -ONE, THREE, THREE)).eval_prog([]) == LineSegment.new(ONE, ONE, THREE, THREE)
tests[124] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(TWO, TWO, FIVE, FIVE)).eval_prog([]) == LineSegment.new(TWO, TWO, FOUR, FOUR)
tests[125] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(FOUR, FOUR, FIVE, FIVE)).eval_prog([]) == Point.new(FOUR, FOUR)
tests[126] = Intersect.new(LineSegment.new(ONE, ONE, FOUR, FOUR), LineSegment.new(-FOUR, -FOUR, ONE, ONE)).eval_prog([]) == Point.new(ONE, ONE)
tests[127] = Intersect.new(LineSegment.new(TWO, TWO, THREE, THREE), LineSegment.new(ONE, ONE, FIVE, FIVE)).eval_prog([]) == LineSegment.new(TWO, TWO, THREE, THREE)

# intersection between two vertical LineSegments
tests[128] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, 4.1, ONE, FIVE)).eval_prog([]).class == NoPoints.new.class
tests[129] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, TWO, ONE, THREE)).eval_prog([]) == LineSegment.new(ONE, TWO, ONE, THREE)
tests[130] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, -ONE, ONE, THREE)).eval_prog([]) == LineSegment.new(ONE, ONE, ONE, THREE)
tests[131] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, TWO, ONE, FIVE)).eval_prog([]) == LineSegment.new(ONE, TWO, ONE, FOUR)
tests[132] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, FOUR, ONE, FIVE)).eval_prog([]) == Point.new(ONE, FOUR)
tests[133] = Intersect.new(LineSegment.new(ONE, ONE, ONE, FOUR), LineSegment.new(ONE, -FOUR, ONE, ONE)).eval_prog([]) == Point.new(ONE, ONE)
tests[134] = Intersect.new(LineSegment.new(ONE, TWO, ONE, THREE), LineSegment.new(ONE, ONE, ONE, FIVE)).eval_prog([]) == LineSegment.new(ONE, TWO, ONE, THREE)

tests.each_with_index {|v,i| puts "#{i}: #{v}"}