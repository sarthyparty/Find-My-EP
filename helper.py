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
    Intersection(halls: [], id: 0, x: 74.97, y: 364.49),
    Intersection(halls: [], id: 1, x: 100.2, y: 364.49),
    Intersection(halls: [], id: 2, x: 100.2, y: 375.33),
    Intersection(halls: [], id: 3, x: 100.2, y: 395.18),
    Intersection(halls: [], id: 4, x: 58.6, y: 395.18),
    Intersection(halls: [], id: 5, x: 58.6, y: 389.39),
    Intersection(halls: [], id: 6, x: 41.8, y: 389.39),
    Intersection(halls: [], id: 7, x: 142.2, y: 375.33),
    Intersection(halls: [], id: 8, x: 148.63, y: 375.33),
    Intersection(halls: [], id: 9, x: 148.63, y: 410.12),
    Intersection(halls: [], id: 10, x: 100.2, y: 410.12),
    Intersection(halls: [], id: 11, x: 142.2, y: 335.22),
    Intersection(halls: [], id: 12, x: 157.27, y: 335.22),
    Intersection(halls: [], id: 13, x: 100.2, y: 453.83),
    Intersection(halls: [], id: 14, x: 156.67, y: 410.12),
    Intersection(halls: [], id: 15, x: 156.67, y: 459.96),
    
    Intersection(halls: [], id: 16, x: 154.05, y: 375.33),
    Intersection(halls: [], id: 17, x: 160.69, y: 375.33),
    Intersection(halls: [], id: 18, x: 160.69, y: 372.12),
    Intersection(halls: [], id: 19, x: 174.11, y: 372.12),
    Intersection(halls: [], id: 20, x: 174.11, y: 366.76),
    Intersection(halls: [], id: 21, x: 183.24, y: 366.76),
    Intersection(halls: [], id: 22, x: 183.24, y: 362.39),
    Intersection(halls: [], id: 23, x: 196.14, y: 362.39),
    Intersection(halls: [], id: 24, x: 196.14, y: 355.98),
    Intersection(halls: [], id: 25, x: 208.19, y: 362.39),
    Intersection(halls: [], id: 26, x: 208.19, y: 355.73),
    Intersection(halls: [], id: 27, x: 214.86, y: 355.73),
    Intersection(halls: [], id: 28, x: 214.86, y: 342.46),
    Intersection(halls: [], id: 29, x: 221.53, y: 342.46),
    Intersection(halls: [], id: 30, x: 214.86, y: 311.50),
    Intersection(halls: [], id: 31, x: 214.86, y: 305.36),
    Intersection(halls: [], id: 32, x: 207.82, y: 311.50),
    Intersection(halls: [], id: 33, x: 207.82, y: 327.32),
    Intersection(halls: [], id: 34, x: 207.82, y: 307.32),
    Intersection(halls: [], id: 35, x: 245.89, y: 355.73),
    Intersection(halls: [], id: 36, x: 245.89, y: 361.03),
    Intersection(halls: [], id: 37, x: 245.89, y: 369.07),
    Intersection(halls: [], id: 38, x: 311.25, y: 369.07),
    Intersection(halls: [], id: 39, x: 311.25, y: 366.07),
    Intersection(halls: [], id: 40, x: 353.55, y: 366.07),
    Intersection(halls: [], id: 41, x: 250.81, y: 369.07),
    Intersection(halls: [], id: 42, x: 250.81, y: 392.55),
    Intersection(halls: [], id: 43, x: 215.61, y: 392.55),
    Intersection(halls: [], id: 44, x: 215.61, y: 297.85),
    Intersection(halls: [], id: 45, x: 208.75, y: 297.85),
    Intersection(halls: [], id: 46, x: 215.61, y: 408.85),
    Intersection(halls: [], id: 47, x: 209.03, y: 408.85),
    Intersection(halls: [], id: 48, x: 262.34, y: 369.07),
    Intersection(halls: [], id: 49, x: 262.34, y: 361.18),
    Intersection(halls: [], id: 50, x: 129.25, y: 335.22),
    Intersection(halls: [], id: 51, x: 160.69, y: 383.30),
'''

halls = [

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
    Intersection(halls= [], id= 31, x= 214.86, y= 305.36),
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

def get_hall(start, end, id):
  d = dist(intersects[start].x, intersects[end].x, intersects[start].y, intersects[end].y)
  s = f'Hall(start: {start}, end: {end}, length: {round(d,2)}, id: {id}),'
  return s

print(convert(to_convert))

ans=input('Enter {start-end-id}, or end')
strs = [

]
while ans!='end':
  stuff = ans.split('-')
  start = int(stuff[0])
  end = int(stuff[1])
  id = int(stuff[2])
  strs.append(get_hall(start,end,id))
  ans = input('Enter {start-end-id}')

print('[')
for s in strs:
  print(s)
print(']')

# for i in intersects:
#   i.x = i.x*1.197-42.64 + 71.68224299065426-68.94080901814404
#   i.y = i.y*1.2-95.33+364.48598035770806-358.87 +390.18691588785066 - 389.5950146256208
#   print(f'Intersection(halls: [], id: {i.id}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

# for h in halls:
#   s = intersects[h.start]
#   e = intersects[h.end]
#   h.length = round(dist(s.x,e.x,s.y,e.y),2)
#   print(f'Hall(start: {h.start}, end: {h.end}, length: {h.length}, id: {h.id}),')


# for i in rooms:
#   i.x = i.x*1.197-42.64 + 71.68224299065426-68.94080901814404
#   i.y = i.y*1.2-95.33+364.48598035770806-358.87+390.18691588785066 - 389.5950146256208
#   s = intersects[halls[i.hall].start]
#   i.startDist = round(dist(i.x, s.x, i.y, s.y),2)
#   print(f'Room(name: "{i.name}", startDist: {i.startDist}, hall: {i.hall}, x: {round(i.x,2)}, y: {round(i.y,2)}),')

