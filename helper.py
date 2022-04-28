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
    Intersection(halls: [], id: 0, x: 65.48, y: 399.44),
    Intersection(halls: [], id: 1, x: 106.76, y: 399.44),
    Intersection(halls: [], id: 2, x: 106.76, y: 394.92),
    Intersection(halls: [], id: 3, x: 113.96, y: 399.44),
    Intersection(halls: [], id: 4, x: 119.13, y: 399.44),
    Intersection(halls: [], id: 5, x: 119.13, y: 387.76),
    Intersection(halls: [], id: 6, x: 119.13, y: 371.81),
    Intersection(halls: [], id: 7, x: 122.87, y: 371.81),
    Intersection(halls: [], id: 8, x: 119.13, y: 417.26),
    Intersection(halls: [], id: 9, x: 146.54, y: 417.26),
    Intersection(halls: [], id: 10, x: 146.54, y: 412.46),
    Intersection(halls: [], id: 11, x: 154.33, y: 387.76),
    Intersection(halls: [], id: 12, x: 166.45, y: 387.76),
    Intersection(halls: [], id: 13, x: 169.56, y: 387.76),
    Intersection(halls: [], id: 14, x: 154.33, y: 353.3),
    Intersection(halls: [], id: 15, x: 146.82, y: 353.3),
    Intersection(halls: [], id: 16, x: 198.94, y: 387.76),
    Intersection(halls: [], id: 17, x: 169.56, y: 420.56),
    Intersection(halls: [], id: 18, x: 198.94, y: 361.87),
    Intersection(halls: [], id: 19, x: 209.94, y: 361.87),
    Intersection(halls: [], id: 20, x: 234.98, y: 361.87),
    Intersection(halls: [], id: 21, x: 234.98, y: 376.67),
    Intersection(halls: [], id: 22, x: 234.98, y: 392.78),
    Intersection(halls: [], id: 23, x: 234.98, y: 405.14),
    Intersection(halls: [], id: 24, x: 208.79, y: 405.14),
    Intersection(halls: [], id: 25, x: 208.79, y: 409.81),
    Intersection(halls: [], id: 26, x: 264.08, y: 376.67),
    Intersection(halls: [], id: 27, x: 264.08, y: 382.92),
    Intersection(halls: [], id: 28, x: 264.08, y: 392.52),
    Intersection(halls: [], id: 29, x: 295.67, y: 382.92),
    Intersection(halls: [], id: 30, x: 297.41, y: 381.28),
    Intersection(halls: [], id: 31, x: 318.82, y: 381.28),

        Hall(start: 0, end: 1, length: 41.28, id: 0),
    Hall(start: 1, end: 2, length: 4.52, id: 1),
    Hall(start: 1, end: 3, length: 7.2, id: 2),
    Hall(start: 3, end: 4, length: 5.17, id: 3),
    Hall(start: 4, end: 5, length: 11.68, id: 4),
    Hall(start: 5, end: 6, length: 15.95, id: 5),
    Hall(start: 6, end: 7, length: 4.02, id: 6),
    Hall(start: 4, end: 8, length: 17.82, id: 7),
    Hall(start: 8, end: 9, length: 27.41, id: 8),
    Hall(start: 9, end: 10, length: 4.8, id: 9),
    Hall(start: 5, end: 11, length: 35.2, id: 10),
    Hall(start: 11, end: 14, length: 34.46, id: 11),
    Hall(start: 14, end: 15, length: 7.51, id: 12),
    Hall(start: 11, end: 12, length: 12.12, id: 13),
    Hall(start: 13, end: 16, length: 29.38, id: 14),
    Hall(start: 16, end: 18, length: 25.89, id: 15),
    Hall(start: 18, end: 19, length: 11.0, id: 16),
    Hall(start: 19, end: 20, length: 25.04, id: 17),
    Hall(start: 20, end: 21, length: 14.8, id: 18),
    Hall(start: 21, end: 22, length: 16.11, id: 19),
    Hall(start: 23, end: 24, length: 26.19, id: 20),
    Hall(start: 22, end: 28, length: 29.1, id: 21),
    Hall(start: 27, end: 28, length: 9.6, id: 22),
    Hall(start: 26, end: 27, length: 6.25, id: 23),
    Hall(start: 21, end: 26, length: 29.1, id: 24),
    Hall(start: 13, end: 17, length: 32.8, id: 25),
    Hall(start: 27, end: 29, length: 31.59, id: 26),
    Hall(start: 29, end: 30, length: 2.39, id: 27),
    Hall(start: 30, end: 31, length: 21.41, id: 28),
    Hall(start: 24, end: 25, length: 4.67, id: 29),
    Hall(start: 22, end: 23, length: 12.36, id: 30),
'''

halls = [
    Hall(start= 0, end= 1, length= 41.28, id= 0),
    Hall(start= 1, end= 2, length= 4.52, id= 1),
    Hall(start= 1, end= 3, length= 7.2, id= 2),
    Hall(start= 3, end= 4, length= 5.17, id= 3),
    Hall(start= 4, end= 5, length= 11.68, id= 4),
    Hall(start= 5, end= 6, length= 15.95, id= 5),
    Hall(start= 6, end= 7, length= 4.02, id= 6),
    Hall(start= 4, end= 8, length= 17.82, id= 7),
    Hall(start= 8, end= 9, length= 27.41, id= 8),
    Hall(start= 9, end= 10, length= 4.8, id= 9),
    Hall(start= 5, end= 11, length= 35.2, id= 10),
    Hall(start= 11, end= 14, length= 34.46, id= 11),
    Hall(start= 14, end= 15, length= 7.51, id= 12),
    Hall(start= 11, end= 12, length= 12.12, id= 13),
    Hall(start= 13, end= 16, length= 29.38, id= 14),
    Hall(start= 16, end= 18, length= 25.89, id= 15),
    Hall(start= 18, end= 19, length= 11.0, id= 16),
    Hall(start= 19, end= 20, length= 25.04, id= 17),
    Hall(start= 20, end= 21, length= 14.8, id= 18),
    Hall(start= 21, end= 22, length= 16.11, id= 19),
    Hall(start= 23, end= 24, length= 26.19, id= 20),
    Hall(start= 22, end= 28, length= 29.1, id= 21),
    Hall(start= 27, end= 28, length= 9.6, id= 22),
    Hall(start= 26, end= 27, length= 6.25, id= 23),
    Hall(start= 21, end= 26, length= 29.1, id= 24),
    Hall(start= 13, end= 17, length= 32.8, id= 25),
    Hall(start= 27, end= 29, length= 31.59, id= 26),
    Hall(start= 29, end= 30, length= 2.39, id= 27),
    Hall(start= 30, end= 31, length= 21.41, id= 28),
    Hall(start= 24, end= 25, length= 4.67, id= 29),
    Hall(start= 22, end= 23, length= 12.36, id= 30),
]

intersects = [
    Intersection(halls= [], id= 0, x= 65.48, y= 399.44),
    Intersection(halls= [], id= 1, x= 106.76, y= 399.44),
    Intersection(halls= [], id= 2, x= 106.76, y= 394.92),
    Intersection(halls= [], id= 3, x= 113.96, y= 399.44),
    Intersection(halls= [], id= 4, x= 119.13, y= 399.44),
    Intersection(halls= [], id= 5, x= 119.13, y= 387.76),
    Intersection(halls= [], id= 6, x= 119.13, y= 371.81),
    Intersection(halls= [], id= 7, x= 122.87, y= 371.81),
    Intersection(halls= [], id= 8, x= 119.13, y= 417.26),
    Intersection(halls= [], id= 9, x= 146.54, y= 417.26),
    Intersection(halls= [], id= 10, x= 146.54, y= 412.46),
    Intersection(halls= [], id= 11, x= 154.33, y= 387.76),
    Intersection(halls= [], id= 12, x= 166.45, y= 387.76),
    Intersection(halls= [], id= 13, x= 169.56, y= 387.76),
    Intersection(halls= [], id= 14, x= 154.33, y= 353.3),
    Intersection(halls= [], id= 15, x= 146.82, y= 353.3),
    Intersection(halls= [], id= 16, x= 198.94, y= 387.76),
    Intersection(halls= [], id= 17, x= 169.56, y= 420.56),
    Intersection(halls= [], id= 18, x= 198.94, y= 361.87),
    Intersection(halls= [], id= 19, x= 209.94, y= 361.87),
    Intersection(halls= [], id= 20, x= 234.98, y= 361.87),
    Intersection(halls= [], id= 21, x= 234.98, y= 376.67),
    Intersection(halls= [], id= 22, x= 234.98, y= 392.78),
    Intersection(halls= [], id= 23, x= 234.98, y= 405.14),
    Intersection(halls= [], id= 24, x= 208.79, y= 405.14),
    Intersection(halls= [], id= 25, x= 208.79, y= 409.81),
    Intersection(halls= [], id= 26, x= 264.08, y= 376.67),
    Intersection(halls= [], id= 27, x= 264.08, y= 382.92),
    Intersection(halls= [], id= 28, x= 264.08, y= 392.52),
    Intersection(halls= [], id= 29, x= 295.67, y= 382.92),
    Intersection(halls= [], id= 30, x= 297.41, y= 381.28),
    Intersection(halls= [], id= 31, x= 318.82, y= 381.28),
]

rooms = [
    Room(name= "313 Math Resource", startDist= 4.52, hall= 1, x= 106.76, y= 394.92),
    Room(name= "314 Classroom", startDist= 8.07, hall= 0, x= 73.55, y= 399.44),
    Room(name= "315 Classroom", startDist= 0, hall= 0, x= 65.48, y= 399.44),
    Room(name= "316 Application Lab", startDist= 0, hall= 0, x= 65.48, y= 399.44),
    Room(name= "317 Application Lab", startDist= 5.02, hall= 0, x= 70.50, y= 399.44),
    Room(name= "318 Classroom", startDist= 8.06, hall= 0, x= 73.55, y= 399.44),
    Room(name= "319 Classroom", startDist= 23.93, hall= 0, x= 89.41, y= 399.44),
    Room(name= "320 Computer Programming", startDist= 27.6, hall= 0, x= 93.08, y= 399.44),
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
  i.x = i.x*1.197-42.64 + 71.68224299065426-68.94080901814404
  i.y = i.y*1.2-95.33+364.48598035770806-358.87 +390.18691588785066 - 389.5950146256208
  print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

for h in halls:
  s = intersects[h.start]
  e = intersects[h.end]
  h.length = round(dist(s.x,e.x,s.y,e.y),2)
  print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


for i in rooms:
  i.x = i.x*1.197-42.64 + 71.68224299065426-68.94080901814404
  i.y = i.y*1.2-95.33+364.48598035770806-358.87+390.18691588785066 - 389.5950146256208
  s = intersects[halls[i.hall].start]
  i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
  print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

