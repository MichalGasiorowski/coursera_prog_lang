class A
  def m1
    self.m2()
  end
  def m2
    1
  end
end
module M
  def m3
    self.m4()
  end
end
class B < A
  def m2
    2
  end
end
class C < A
  include M
  def m4
    3
  end
end
class D < B
  include M
end 

D.new.m3