from distutils.command.install_egg_info import to_filename
from tokenize import String


def convert(inters):
  return inters.replace(":", "=")

class Intersection:
  def __init__(self, halls, id, x, y):
    self.id = id
    self.x = x
    self.y = y

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
'''

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

def dist(x1, x2, y1, y2):
  return abs((x2-x1)**2 + (y2-y1)**2)**0.5

def get_hall(start, end, id):
  d = dist(intersects[start].x, intersects[end].x, intersects[start].y, intersects[end].y)
  s = f'Hall(start: {start}, end: {end}, length: {round(d,2)}, id: {id}),'
  return s

# print(convert(to_convert))

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


