from distutils.command.install_egg_info import to_filename
from tokenize import String


def convert(inters):
  return inters.replace(":", "=")

class Intersection:
  def __init__(self, halls, id, x, y):
    self.id = id
    self.x = x
    self.y = y

class Room:
  def __init__(self, name, startDist, hall, x, y):
    self.name = name
    self.startDist = startDist
    self.hall = hall
    self.x = x
    self.y = y

class Hall:
  def __init__(self, start, end, length, id):
    self.start = start
    self.end = end
    self.length = length
    self.id = id

to_convert = '''
'''

halls = [
    Hall(start= 0, end= 1, length= 21.08, id= 0),
    Hall(start= 1, end= 2, length= 9.04, id= 1),
    Hall(start= 2, end= 3, length= 16.54, id= 2),
    Hall(start= 3, end= 4, length= 34.75, id= 3),
    Hall(start= 4, end= 5, length= 4.83, id= 4),
    Hall(start= 5, end= 6, length= 14.04, id= 5),
    Hall(start= 2, end= 7, length= 35.09, id= 6),
    Hall(start= 7, end= 8, length= 5.37, id= 7),
    Hall(start= 8, end= 9, length= 27.54, id= 8),
    Hall(start= 9, end= 10, length= 40.46, id= 9),
    Hall(start= 10, end= 3, length= 11.0, id= 10),
    Hall(start= 7, end= 11, length= 31.43, id= 11),
    Hall(start= 11, end= 12, length= 12.59, id= 12),
    Hall(start= 10, end= 13, length= 39.87, id= 13),
    Hall(start= 9, end= 14, length= 6.72, id= 14),
    Hall(start= 14, end= 15, length= 42.98, id= 15),
]

intersects = [
    Intersection(halls= [], id= 0, x= 98.25, y= 378.5),
    Intersection(halls= [], id= 1, x= 119.33, y= 378.5),
    Intersection(halls= [], id= 2, x= 119.33, y= 387.54),
    Intersection(halls= [], id= 3, x= 119.33, y= 404.08),
    Intersection(halls= [], id= 4, x= 84.58, y= 404.08),
    Intersection(halls= [], id= 5, x= 84.58, y= 399.25),
    Intersection(halls= [], id= 6, x= 70.54, y= 399.25),
    Intersection(halls= [], id= 7, x= 154.42, y= 387.54),
    Intersection(halls= [], id= 8, x= 159.79, y= 387.54),
    Intersection(halls= [], id= 9, x= 159.79, y= 416.53),
    Intersection(halls= [], id= 10, x= 119.33, y= 416.53),
    Intersection(halls= [], id= 11, x= 154.42, y= 354.11),
    Intersection(halls= [], id= 12, x= 167.01, y= 354.11),
    Intersection(halls= [], id= 13, x= 119.33, y= 452.95),
    Intersection(halls= [], id= 14, x= 166.51, y= 416.53),
    Intersection(halls= [], id= 15, x= 166.51 , y= 458.06),
]

rooms = [
    Room(name= "130 Classroom", startDist= 8.71, hall= 0, x= 106.96, y= 378.5),
    Room(name= "129 Classroom", startDist= 11.38, hall= 0, x= 109.63, y= 378.5),
    Room(name= "131 Computer Lab", startDist= 8.08, hall= 1, x= 119.33, y= 386.58),
    Room(name= "128 Classroom", startDist= 3.13, hall= 6, x= 122.46, y= 387.54),
    Room(name= "127 Classroom", startDist= 3.13, hall= 6, x= 122.46, y= 387.54),
    Room(name= "126 Classroom", startDist= 17.71, hall= 6, x= 137.04, y= 387.54),
    Room(name= "125 Classroom", startDist= 17.71, hall= 6, x= 137.04, y= 387.54),
    Room(name= "124 Classroom", startDist= 27.09, hall= 6, x= 146.42, y= 387.54),
    Room(name= "117 Classroom", startDist= 7.75, hall= 8, x= 159.79, y= 395.29),
    Room(name= "116 Resource", startDist= 15.04, hall= 8, x= 159.79, y= 402.58),
    Room(name= "115 Classroom", startDist= 16.92, hall= 8, x= 159.79, y= 404.46),
    Room(name= "114A Classroom", startDist= 19.04, hall= 8, x= 159.79, y= 406.58),
    Room(name= "114B Classroom", startDist= 21.29, hall= 8, x= 159.79, y= 408.83),
    Room(name= "132 Student Resource", startDist= 10.17, hall= 3, x= 109.16, y= 404.08),
    Room(name= "133 Offices", startDist= 23.58, hall= 3, x= 95.75, y= 404.08),
    Room(name= "134 Classroom", startDist= 1.12, hall= 5, x= 83.46, y= 399.25),
    Room(name= "135 Classroom", startDist= 10.96, hall= 5, x= 73.62, y= 399.25),
    Room(name= "139 Flex", startDist= 34.75, hall= 3, x= 84.58, y= 404.08),
    Room(name= "138 Classroom", startDist= 34.75, hall= 3, x= 84.58, y= 404.08),
    Room(name= "137 Classroom", startDist= 13.37, hall= 5, x= 71.21, y= 399.25),
    Room(name= "136 Lab", startDist= 13.37, hall= 5, x= 71.21, y= 399.25),
    Room(name= "121 Classroom", startDist= 2.4, hall= 12, x= 156.63, y= 354.11),
    Room(name= "120 Classroom", startDist= 4.05, hall= 12, x= 158.47, y= 354.11),
    Room(name= "119 Classroom", startDist= 4.05, hall= 12, x= 158.47, y= 354.11),
    Room(name= "122 Classroom", startDist= 28.82, hall= 11, x= 154.42, y= 356.72),
    Room(name= "123 Classroom", startDist= 12.68, hall= 11, x= 154.42, y= 372.86),
    Room(name= "118 Classroom", startDist= 12.68, hall= 11, x= 154.42, y= 372.86),
    Room(name= "144 Weight Room", startDist= 24.95, hall= 13, x= 119.33, y= 436.53),
    Room(name= "143 Boys Locker", startDist= 39.87, hall= 13, x= 119.33, y= 451.95),
    Room(name= "142 Girls Locker", startDist= 27.22, hall= 13, x= 119.33, y= 440.80),
    Room(name= "145 Fitness Center", startDist= 13.76, hall= 13, x= 119.33, y= 426.90),
    Room(name= "146 Training", startDist= 26.09, hall= 9, x= 145.42 , y= 416.53),
    Room(name= "147 Boys Locker", startDist= 10.12, hall= 15, x= 166.51, y= 423.70),
    Room(name= "151 Girls Locker", startDist= 10.12, hall= 15, x= 166.51, y= 423.70),
    Room(name= "148 Boys Locker", startDist= 27.41, hall= 15, x= 166.51, y= 440.99),
    Room(name= "150 Girls Locker", startDist= 27.41, hall= 15, x= 166.51, y= 440.99),
    Room(name= "151A Office", startDist= 7.97, hall= 15, x= 166.51, y= 421.55)
]



def dist(x1, x2, y1, y2):
  return abs((x2-x1)**2 + (y2-y1)**2)**0.5

# def get_hall(start, end, id):
#   d = dist(intersects[start].x, intersects[end].x, intersects[start].y, intersects[end].y)
#   s = f'Hall(start: {start}, end: {end}, length: {round(d,2)}, id: {id}),'
#   return s

# print(convert(to_convert))

# ans=input('Enter {start-end-id}, or end')
# strs = [

# ]
# while ans!='end':
#   stuff = ans.split('-')
#   start = int(stuff[0])
#   end = int(stuff[1])
#   id = int(stuff[2])
#   strs.append(get_hall(start,end,id))
#   ans = input('Enter {start-end-id}')

# print('[')
# for s in strs:
#   print(s)
# print(']')

for i in intersects:
  i.x = i.x*1.197-42.64
  i.y = i.y*1.2-95.33
  print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

for h in halls:
  s = intersects[h.start]
  e = intersects[h.end]
  h.length = round(dist(s.x,e.x,s.y,e.y),2)
  print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


for i in rooms:
  i.x = i.x*1.197-42.64
  i.y = i.y*1.2-95.33
  s = intersects[halls[i.hall].start]
  i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
  print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')



