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
    Hall(start: 0, end: 1, length: 25.23, id: 0),
    Hall(start: 1, end: 2, length: 10.85, id: 1),
    Hall(start: 2, end: 3, length: 19.85, id: 2),
    Hall(start: 3, end: 4, length: 41.6, id: 3),
    Hall(start: 4, end: 5, length: 5.8, id: 4),
    Hall(start: 5, end: 6, length: 16.81, id: 5),
    Hall(start: 2, end: 7, length: 42.0, id: 6),
    Hall(start: 7, end: 8, length: 6.43, id: 7),
    Hall(start: 8, end: 9, length: 34.79, id: 8),
    Hall(start: 10, end: 53, length: 33.84, id: 9),
    Hall(start: 10, end: 3, length: 14.94, id: 10),
    Hall(start: 7, end: 11, length: 40.12, id: 11),
    Hall(start: 11, end: 12, length: 15.07, id: 12),
    Hall(start: 10, end: 13, length: 43.7, id: 13),
    Hall(start: 9, end: 58, length: 5.00, id: 14),
    Hall(start: 14, end: 15, length: 49.84, id: 15),
    Hall(start: 11, end: 50, length: 12.95, id: 16),
    Hall(start: 17, end: 51, length: 7.97, id: 17),
    Hall(start: 18, end: 19, length: 13.42, id: 18),
    Hall(start: 19, end: 20, length: 5.36, id: 19),
    Hall(start: 20, end: 21, length: 9.13, id: 20),
    Hall(start: 22, end: 23, length: 12.9, id: 21),
    Hall(start: 23, end: 24, length: 6.41, id: 22),
    Hall(start: 23, end: 25, length: 12.05, id: 23),
    Hall(start: 25, end: 26, length: 6.66, id: 24),
    Hall(start: 26, end: 27, length: 6.67, id: 25),
    Hall(start: 27, end: 28, length: 13.27, id: 26),
    Hall(start: 28, end: 29, length: 6.67, id: 27),
    Hall(start: 28, end: 30, length: 30.96, id: 28),
    Hall(start: 30, end: 31, length: 6.14, id: 29),
    Hall(start: 30, end: 32, length: 7.04, id: 30),
    Hall(start: 32, end: 34, length: 4.18, id: 31),
    Hall(start: 32, end: 33, length: 15.82, id: 32),
    Hall(start: 27, end: 35, length: 31.03, id: 33),
    Hall(start: 35, end: 36, length: 5.3, id: 34),
    Hall(start: 36, end: 49, length: 16.45, id: 35),
    Hall(start: 48, end: 49, length: 7.89, id: 36),
    Hall(start: 37, end: 41, length: 4.92, id: 37),
    Hall(start: 8, end: 16, length: 5.42, id: 38),
    Hall(start: 16, end: 17, length: 6.64, id: 39),
    Hall(start: 17, end: 18, length: 3.21, id: 40),
    Hall(start: 36, end: 37, length: 8.04, id: 41),
    Hall(start: 38, end: 48, length: 48.91, id: 42),
    Hall(start: 38, end: 39, length: 3.0, id: 43),
    Hall(start: 39, end: 57, length: 23.27, id: 44),
    Hall(start: 41, end: 42, length: 23.48, id: 45),
    Hall(start: 42, end: 43, length: 35.2, id: 46),
    Hall(start: 43, end: 44, length: 94.7, id: 47),
    Hall(start: 44, end: 46, length: 111.0, id: 48),
    Hall(start: 46, end: 47, length: 6.58, id: 49),
    Hall(start: 45, end: 47, length: 111.0, id: 50),
    Hall(start: 44, end: 45, length: 6.86, id: 51),
    Hall(start: 25, end: 45, length: 64.54, id: 52),
    Hall(start: 14, end: 55, length: 47.73, id: 53),
    Hall(start: 21, end: 22, length: 4.37, id: 54),
    Hall(start: 41, end: 48, length: 11.53, id: 55),
    Hall(start: 6, end: 52, length: 15.02, id: 56),
    Hall(start: 9, end: 53, length: 14.36, id: 57),
    Hall(start: 47, end: 55, length: 4.18, id: 58),
    Hall(start: 55, end: 56, length: 7.20, id: 59),
    Hall(start: 53, end: 54, length: 7.80, id: 60),
    Hall(start: 40, end: 57, length: 16.57, id: 61),
    Hall(start: 14, end: 58, length: 3.43, id: 62),
    Hall(start: 58, end: 59, length: 6.24, id: 63),
    Hall(start: 10, end: 60, length: 6.57, id: 64)
'''

halls = [
    Hall(start= 0, end= 1, length= 25.23, id= 0),
    Hall(start= 1, end= 2, length= 10.85, id= 1),
    Hall(start= 2, end= 3, length= 19.85, id= 2),
    Hall(start= 3, end= 4, length= 41.6, id= 3),
    Hall(start= 4, end= 5, length= 5.8, id= 4),
    Hall(start= 5, end= 6, length= 16.81, id= 5),
    Hall(start= 2, end= 7, length= 42.0, id= 6),
    Hall(start= 7, end= 8, length= 6.43, id= 7),
    Hall(start= 8, end= 9, length= 34.79, id= 8),
    Hall(start= 10, end= 53, length= 33.84, id= 9),
    Hall(start= 10, end= 3, length= 14.94, id= 10),
    Hall(start= 7, end= 11, length= 40.12, id= 11),
    Hall(start= 11, end= 12, length= 15.07, id= 12),
    Hall(start= 10, end= 13, length= 43.7, id= 13),
    Hall(start= 9, end= 58, length= 5.00, id= 14),
    Hall(start= 14, end= 15, length= 49.84, id= 15),
    Hall(start= 11, end= 50, length= 12.95, id= 16),
    Hall(start= 17, end= 51, length= 7.97, id= 17),
    Hall(start= 18, end= 19, length= 13.42, id= 18),
    Hall(start= 19, end= 20, length= 5.36, id= 19),
    Hall(start= 20, end= 21, length= 9.13, id= 20),
    Hall(start= 22, end= 23, length= 12.9, id= 21),
    Hall(start= 23, end= 24, length= 6.41, id= 22),
    Hall(start= 23, end= 25, length= 12.05, id= 23),
    Hall(start= 25, end= 26, length= 6.66, id= 24),
    Hall(start= 26, end= 27, length= 6.67, id= 25),
    Hall(start= 27, end= 28, length= 13.27, id= 26),
    Hall(start= 28, end= 29, length= 6.67, id= 27),
    Hall(start= 28, end= 30, length= 30.96, id= 28),
    Hall(start= 30, end= 31, length= 6.14, id= 29),
    Hall(start= 30, end= 32, length= 7.04, id= 30),
    Hall(start= 32, end= 34, length= 4.18, id= 31),
    Hall(start= 32, end= 33, length= 15.82, id= 32),
    Hall(start= 27, end= 35, length= 31.03, id= 33),
    Hall(start= 35, end= 36, length= 5.3, id= 34),
    Hall(start= 36, end= 49, length= 16.45, id= 35),
    Hall(start= 48, end= 49, length= 7.89, id= 36),
    Hall(start= 37, end= 41, length= 4.92, id= 37),
    Hall(start= 8, end= 16, length= 5.42, id= 38),
    Hall(start= 16, end= 17, length= 6.64, id= 39),
    Hall(start= 17, end= 18, length= 3.21, id= 40),
    Hall(start= 36, end= 37, length= 8.04, id= 41),
    Hall(start= 38, end= 48, length= 48.91, id= 42),
    Hall(start= 38, end= 39, length= 3.0, id= 43),
    Hall(start= 39, end= 57, length= 23.27, id= 44),
    Hall(start= 41, end= 42, length= 23.48, id= 45),
    Hall(start= 42, end= 43, length= 35.2, id= 46),
    Hall(start= 43, end= 44, length= 94.7, id= 47),
    Hall(start= 44, end= 46, length= 111.0, id= 48),
    Hall(start= 46, end= 47, length= 6.58, id= 49),
    Hall(start= 45, end= 47, length= 111.0, id= 50),
    Hall(start= 44, end= 45, length= 6.86, id= 51),
    Hall(start= 25, end= 45, length= 64.54, id= 52),
    Hall(start= 14, end= 55, length= 47.73, id= 53),
    Hall(start= 21, end= 22, length= 4.37, id= 54),
    Hall(start= 41, end= 48, length= 11.53, id= 55),
    Hall(start= 6, end= 52, length= 15.02, id= 56),
    Hall(start= 9, end= 53, length= 14.36, id= 57),
    Hall(start= 47, end= 55, length= 4.18, id= 58),
    Hall(start= 55, end= 56, length= 7.20, id= 59),
    Hall(start= 53, end= 54, length= 7.80, id= 60),
    Hall(start= 40, end= 57, length= 16.57, id= 61),
    Hall(start= 14, end= 58, length= 3.43, id= 62),
    Hall(start= 58, end= 59, length= 6.24, id= 63),
    Hall(start= 10, end= 60, length= 6.57, id= 64)
]

intersects = [
    Intersection(halls= [], id= 0, x= 74.97, y= 364.49),
    Intersection(halls= [], id= 1, x= 100.2, y= 364.49),
    Intersection(halls= [], id= 2, x= 100.2, y= 375.33),
    Intersection(halls= [], id= 3, x= 100.2, y= 395.18),
    Intersection(halls= [], id= 4, x= 58.6, y= 395.18),
    Intersection(halls= [], id= 5, x= 58.6, y= 389.39),
    Intersection(halls= [], id= 6, x= 41.8, y= 389.39),
    Intersection(halls= [], id= 7, x= 142.2, y= 375.33),
    Intersection(halls= [], id= 8, x= 148.63, y= 375.33),
    Intersection(halls= [], id= 9, x= 148.63, y= 410.12),
    Intersection(halls= [], id= 10, x= 100.2, y= 410.12),
    Intersection(halls= [], id= 11, x= 142.2, y= 335.22),
    Intersection(halls= [], id= 12, x= 157.27, y= 335.22),
    Intersection(halls= [], id= 13, x= 100.2, y= 453.83),
    Intersection(halls= [], id= 14, x= 156.67, y= 410.12),
    Intersection(halls= [], id= 15, x= 156.67, y= 459.96),
    Intersection(halls= [], id= 16, x= 154.05, y= 375.33),
    Intersection(halls= [], id= 17, x= 160.69, y= 375.33),
    Intersection(halls= [], id= 18, x= 160.69, y= 372.12),
    Intersection(halls= [], id= 19, x= 174.11, y= 372.12),
    Intersection(halls= [], id= 20, x= 174.11, y= 366.76),
    Intersection(halls= [], id= 21, x= 183.24, y= 366.76),
    Intersection(halls= [], id= 22, x= 183.24, y= 362.39),
    Intersection(halls= [], id= 23, x= 196.14, y= 362.39),
    Intersection(halls= [], id= 24, x= 196.14, y= 355.98),
    Intersection(halls= [], id= 25, x= 208.19, y= 362.39),
    Intersection(halls= [], id= 26, x= 208.19, y= 355.73),
    Intersection(halls= [], id= 27, x= 214.86, y= 355.73),
    Intersection(halls= [], id= 28, x= 214.86, y= 342.46),
    Intersection(halls= [], id= 29, x= 221.53, y= 342.46),
    Intersection(halls= [], id= 30, x= 214.86, y= 311.50),
    Intersection(halls= [], id= 31, x= 214.86, y= 302.55),
    Intersection(halls= [], id= 32, x= 207.82, y= 311.50),
    Intersection(halls= [], id= 33, x= 207.82, y= 327.32),
    Intersection(halls= [], id= 34, x= 207.82, y= 307.32),
    Intersection(halls= [], id= 35, x= 245.89, y= 355.73),
    Intersection(halls= [], id= 36, x= 245.89, y= 361.03),
    Intersection(halls= [], id= 37, x= 245.89, y= 369.07),
    Intersection(halls= [], id= 38, x= 311.25, y= 369.07),
    Intersection(halls= [], id= 39, x= 311.25, y= 366.07),
    Intersection(halls= [], id= 40, x= 353.55, y= 366.07),
    Intersection(halls= [], id= 41, x= 250.81, y= 369.07),
    Intersection(halls= [], id= 42, x= 250.81, y= 392.55),
    Intersection(halls= [], id= 43, x= 215.61, y= 392.55),
    Intersection(halls= [], id= 44, x= 215.61, y= 297.85),
    Intersection(halls= [], id= 45, x= 208.75, y= 297.85),
    Intersection(halls= [], id= 46, x= 215.61, y= 408.85),
    Intersection(halls= [], id= 47, x= 209.03, y= 408.85),
    Intersection(halls= [], id= 48, x= 262.34, y= 369.07),
    Intersection(halls= [], id= 49, x= 262.34, y= 361.18),
    Intersection(halls= [], id= 50, x= 129.25, y= 335.22),
    Intersection(halls= [], id= 51, x= 160.69, y= 383.30),
    Intersection(halls= [], id= 52, x= 41.80, y= 373.73),
    Intersection(halls= [], id= 53, x= 134.02, y= 410.12),
    Intersection(halls= [], id= 54, x= 134.02, y= 400.93),
    Intersection(halls= [], id= 55, x= 204.52, y= 408.85),
    Intersection(halls= [], id= 56, x= 204.52, y= 401.40),
    Intersection(halls= [], id= 57, x= 336.32, y= 366.07),
    Intersection(halls= [], id= 58, x= 153.46, y= 410.12),
    Intersection(halls= [], id= 59, x= 153.46, y= 415.73),
    Intersection(halls= [], id= 60, x= 93.83, y= 410.12)
]

rooms = [
    Room(name= "171", startDist= 0, hall= 36, x= 263.77, y= 360.65),
    Room(name= "169", startDist= 0, hall= 42, x= 287.38, y= 366.16),
    Room(name= "168", startDist= 0, hall= 42, x= 301.15, y= 367.63),
    Room(name= "167", startDist= 0, hall= 44, x= 313, y= 366.1),
    Room(name= "166", startDist= 0, hall= 44, x= 333.61, y= 366.1),
    Room(name= "165", startDist= 0, hall= 44, x= 343.24, y= 365.8),
    Room(name= "162", startDist= 0, hall= 42, x= 262.93, y= 369.53),
    Room(name= "163", startDist= 0, hall= 42, x= 289.28, y= 369.53),
    Room(name= "164", startDist= 0, hall= 42, x= 301.21, y= 369.53),
    Room(name= "171 Art", startDist= 0, hall= 36, x= 263.77, y= 360.65),
    Room(name= "169 Art", startDist= 0, hall= 42, x= 287.38, y= 366.16),
    Room(name= "168 Classroom", startDist= 0, hall= 42, x= 301.15, y= 367.63),
    Room(name= "167 Classroom", startDist= 0, hall= 44, x= 313, y= 366.1),
    Room(name= "166 Classroom", startDist= 0, hall= 44, x= 333.61, y= 366.1),
    Room(name= "165 Classroom", startDist= 0, hall= 44, x= 343.24, y= 365.8),
    Room(name= "162 Classroom", startDist= 0, hall= 42, x= 262.93, y= 369.53),
    Room(name= "163 Classroom", startDist= 0, hall= 42, x= 289.28, y= 369.53),
    Room(name= "164 Classroom", startDist= 0, hall= 42, x= 301.21, y= 369.53),
    Room(name= "101 Main Office", startDist= 0, hall= 28, x= 217.35, y= 324.01),
    Room(name= "100 Student Center South", startDist= 0, hall= 32, x= 206.6, y= 328.03),
    Room(name= "104 Health", startDist= 0, hall= 32, x= 207.07, y= 338.38),
    Room(name= "106 Classroom", startDist= 0, hall= 21, x= 183.02, y= 361.59),
    Room(name= "107 Special Ed Office", startDist= 0, hall= 18, x= 165.67, y= 371.83),
    Room(name= "112 Special Ed Resources", startDist= 0, hall= 17, x= 160, y= 383.8),
    Room(name= "111 Classroom", startDist= 0, hall= 17, x= 162.15, y= 383.2),
    Room(name= "113 Classroom", startDist= 0, hall= 17, x= 159.19, y= 377.82),
    Room(name= "110 Classroom", startDist= 0, hall= 17, x= 162.08, y= 375.95),
    Room(name= "109 Classroom", startDist= 0, hall= 18, x= 175.2, y= 373.77),
    Room(name= "154A South Common Collab", startDist= 0, hall= 52, x= 206.63, y= 380.96),
    Room(name= "152 Wrestling Room", startDist= 0, hall= 53, x= 179.62, y= 410.87),
    Room(name= "155 Registration Office", startDist= 0, hall= 52, x= 206.85, y= 369.07)
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

# for i in intersects:
#   i.x = i.x*1.197-42.64 + 71.68224299065426-68.94080901814404
#   i.y = i.y*1.2-95.33+364.48598035770806-358.87 +390.18691588785066 - 389.5950146256208
#   print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

for h in halls:
  s = intersects[h.start]
  e = intersects[h.end]
  h.length = round(dist(s.x,e.x,s.y,e.y),2)
  print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


for i in rooms:
  i.x = i.x #*1.197-42.64 + 71.68224299065426-68.94080901814404
  i.y = i.y #*1.2-95.33+364.48598035770806-358.87+390.18691588785066 - 389.5950146256208
  s = intersects[halls[i.hall].start]
  i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
  print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

