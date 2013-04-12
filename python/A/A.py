
class A():
    def __init__(self):
        print 'A'

    def func(self):
        print 'a'


class B(A):
    def hello(self):
        super(B, self).func()
        A.func(self)


B()


