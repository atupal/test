

class closure:
    def add_maker(self,a):
        def add(b):
            return a + b

        return add

print closure().add_maker(1)(2)
