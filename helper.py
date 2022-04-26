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
    Intersection(halls: [], id: 0, x: 70.65, y: 399.06),
    Intersection(halls: [], id: 1, x: 99.38, y: 399.06),
    Intersection(halls: [], id: 2, x: 99.38, y: 386.07),
    Intersection(halls: [], id: 3, x: 99.38, y: 404.51),
    Intersection(halls: [], id: 4, x: 119.10, y: 399.06),
    Intersection(halls: [], id: 5, x: 119.10, y: 371.99),
    Intersection(halls: [], id: 6, x: 122.74, y: 371.99),
    Intersection(halls: [], id: 7, x: 119.10, y: 387.88),
    Intersection(halls: [], id: 8, x: 113.74, y: 404.51),
    Intersection(halls: [], id: 9, x: 119.10, y: 404.51),
    Intersection(halls: [], id: 10, x: 119.10, y: 417.35),
    Intersection(halls: [], id: 11, x: 119.10, y: 435.70),
    Intersection(halls: [], id: 12, x: 115.64, y: 439.07),
    Intersection(halls: [], id: 13, x: 115.64, y: 468.94),
    Intersection(halls: [], id: 14, x: 130.81, y: 468.94),
    Intersection(halls: [], id: 15, x: 146.82, y: 468.94),
    Intersection(halls: [], id: 16, x: 166.32, y: 468.94),
    Intersection(halls: [], id: 17, x: 146.82, y: 461.43),
    Intersection(halls: [], id: 18, x: 166.32, y: 461.43),
    Intersection(halls: [], id: 19, x: 166.32, y: 458.10),
    Intersection(halls: [], id: 20, x: 210.59, y: 462.93),
    Intersection(halls: [], id: 21, x: 210.59, y: 417.35),
    Intersection(halls: [], id: 22, x: 210.59, y: 428.63),
    Intersection(halls: [], id: 23, x: 214.64, y: 428.63),
    Intersection(halls: [], id: 24, x: 218.07, y: 428.63),
    Intersection(halls: [], id: 25, x: 218.07, y: 417.35),
    Intersection(halls: [], id: 26, x: 238.97, y: 417.35),
    Intersection(halls: [], id: 27, x: 210.59, y: 412.39),
    Intersection(halls: [], id: 28, x: 205.79, y: 417.35),
    Intersection(halls: [], id: 29, x: 166.26, y: 417.35),
    Intersection(halls: [], id: 30, x: 166.26, y: 419.93),
    Intersection(halls: [], id: 31, x: 286.26, y: 412.39),
    Intersection(halls: [], id: 32, x: 205.79, y: 410.09),
    Intersection(halls: [], id: 33, x: 260.56, y: 412.39),
    Intersection(halls: [], id: 34, x: 260.56, y: 444.49),
    Intersection(halls: [], id: 35, x: 249.13, y: 443.73),
    Intersection(halls: [], id: 36, x: 260.56, y: 450.69),
    Intersection(halls: [], id: 37, x: 286.26, y: 444.49),
    Intersection(halls: [], id: 38, x: 312.18, y: 444.49),
    Intersection(halls: [], id: 39, x: 299.25, y: 410.80),
    Intersection(halls: [], id: 40, x: 312.18, y: 410.80),
    Intersection(halls: [], id: 41, x: 370.28, y: 410.80),
    Intersection(halls: [], id: 42, x: 299.25, y: 395.11),
    Intersection(halls: [], id: 43, x: 296.54, y: 395.11),
    Intersection(halls: [], id: 44, x: 296.54, y: 380.90),
    Intersection(halls: [], id: 45, x: 299.91, y: 380.90),
    Intersection(halls: [], id: 46, x: 294.39, y: 390.50),
    Intersection(halls: [], id: 47, x: 319.31, y: 380.90),
    Intersection(halls: [], id: 48, x: 272.87, y: 390.50),
    Intersection(halls: [], id: 49, x: 272.87, y: 392.24),
    Intersection(halls: [], id: 50, x: 239.06, y: 392.24),
    Intersection(halls: [], id: 51, x: 239.06, y: 390.50),
    Intersection(halls: [], id: 52, x: 239.06, y: 412.39),
    Intersection(halls: [], id: 53, x: 239.06, y: 381.25),
    Intersection(halls: [], id: 54, x: 234.42, y: 390.50),
    Intersection(halls: [], id: 55, x: 232.46, y: 365.55),
    Intersection(halls: [], id: 56, x: 227.54, y: 365.55),
    Intersection(halls: [], id: 57, x: 227.54, y: 356.48),
    Intersection(halls: [], id: 58, x: 227.54, y: 362.46),
    Intersection(halls: [], id: 59, x: 221.96, y: 362.46),
    Intersection(halls: [], id: 60, x: 210.59, y: 362.46),
    Intersection(halls: [], id: 61, x: 208.85, y: 353.93),
    Intersection(halls: [], id: 62, x: 208.85, y: 329.16),
    Intersection(halls: [], id: 63, x: 198.50, y: 353.93),
    Intersection(halls: [], id: 64, x: 146.67, y: 417.35),
    Intersection(halls: [], id: 65, x: 146.67, y: 412.46),
    Intersection(halls: [], id: 66, x: 188.13, y: 352.71),
    Intersection(halls: [], id: 67, x: 198.50, y: 352.71),
    Intersection(halls: [], id: 68, x: 165.73, y: 353.49),
    Intersection(halls: [], id: 69, x: 154.14, y: 353.49),
    Intersection(halls: [], id: 70, x: 147.04, y: 353.49),
    Intersection(halls: [], id: 71, x: 154.14, y: 387.88),
    Intersection(halls: [], id: 72, x: 166.76, y: 387.88),
    Intersection(halls: [], id: 73, x: 253.83, y: 390.50),
    Intersection(halls: [], id: 74, x: 220.90, y: 371.43),
    Intersection(halls: [], id: 75, x: 65.92, y: 387.13),
    Intersection(halls: [], id: 76, x: 119.10, y: 415.58),
    Intersection(halls: [], id: 77, x: 114.01, y: 415.58),
    Intersection(halls: [], id: 78, x: 154.92, y: 483.21),
    Intersection(halls: [], id: 79, x: 144.86, y: 493.77),
    Intersection(halls: [], id: 80, x: 119.53, y: 468.94),
    Intersection(halls: [], id: 81, x: 115.64, y: 464.98),
    Intersection(halls: [], id: 82, x: 119.53, y: 464.98),
    Intersection(halls: [], id: 83, x: 180.19, y: 468.94),
    Intersection(halls: [], id: 84, x: 190.87, y: 468.94),
    Intersection(halls: [], id: 85, x: 190.87, y: 462.93),
    Intersection(halls: [], id: 86, x: 218.07, y: 433.27),
'''

intersects = [
    Intersection(halls= [], id= 0, x= 70.65, y= 399.06),
    Intersection(halls= [], id= 1, x= 99.38, y= 399.06),
    Intersection(halls= [], id= 2, x= 99.38, y= 386.07),
    Intersection(halls= [], id= 3, x= 99.38, y= 404.51),
    Intersection(halls= [], id= 4, x= 119.10, y= 399.06),
    Intersection(halls= [], id= 5, x= 119.10, y= 371.99),
    Intersection(halls= [], id= 6, x= 122.74, y= 371.99),
    Intersection(halls= [], id= 7, x= 119.10, y= 387.88),
    Intersection(halls= [], id= 8, x= 113.74, y= 404.51),
    Intersection(halls= [], id= 9, x= 119.10, y= 404.51),
    Intersection(halls= [], id= 10, x= 119.10, y= 417.35),
    Intersection(halls= [], id= 11, x= 119.10, y= 435.70),
    Intersection(halls= [], id= 12, x= 115.64, y= 439.07),
    Intersection(halls= [], id= 13, x= 115.64, y= 468.94),
    Intersection(halls= [], id= 14, x= 130.81, y= 468.94),
    Intersection(halls= [], id= 15, x= 146.82, y= 468.94),
    Intersection(halls= [], id= 16, x= 166.32, y= 468.94),
    Intersection(halls= [], id= 17, x= 146.82, y= 461.43),
    Intersection(halls= [], id= 18, x= 166.32, y= 461.43),
    Intersection(halls= [], id= 19, x= 166.32, y= 458.10),
    Intersection(halls= [], id= 20, x= 210.59, y= 462.93),
    Intersection(halls= [], id= 21, x= 210.59, y= 417.35),
    Intersection(halls= [], id= 22, x= 210.59, y= 428.63),
    Intersection(halls= [], id= 23, x= 214.64, y= 428.63),
    Intersection(halls= [], id= 24, x= 218.07, y= 428.63),
    Intersection(halls= [], id= 25, x= 218.07, y= 417.35),
    Intersection(halls= [], id= 26, x= 238.97, y= 417.35),
    Intersection(halls= [], id= 27, x= 210.59, y= 412.39),
    Intersection(halls= [], id= 28, x= 205.79, y= 417.35),
    Intersection(halls= [], id= 29, x= 166.26, y= 417.35),
    Intersection(halls= [], id= 30, x= 166.26, y= 419.93),
    Intersection(halls= [], id= 31, x= 286.26, y= 412.39),
    Intersection(halls= [], id= 32, x= 205.79, y= 410.09),
    Intersection(halls= [], id= 33, x= 260.56, y= 412.39),
    Intersection(halls= [], id= 34, x= 260.56, y= 444.49),
    Intersection(halls= [], id= 35, x= 249.13, y= 443.73),
    Intersection(halls= [], id= 36, x= 260.56, y= 450.69),
    Intersection(halls= [], id= 37, x= 286.26, y= 444.49),
    Intersection(halls= [], id= 38, x= 312.18, y= 444.49),
    Intersection(halls= [], id= 39, x= 299.25, y= 410.80),
    Intersection(halls= [], id= 40, x= 312.18, y= 410.80),
    Intersection(halls= [], id= 41, x= 370.28, y= 410.80),
    Intersection(halls= [], id= 42, x= 299.25, y= 395.11),
    Intersection(halls= [], id= 43, x= 296.54, y= 395.11),
    Intersection(halls= [], id= 44, x= 296.54, y= 380.90),
    Intersection(halls= [], id= 45, x= 299.91, y= 380.90),
    Intersection(halls= [], id= 46, x= 294.39, y= 390.50),
    Intersection(halls= [], id= 47, x= 319.31, y= 380.90),
    Intersection(halls= [], id= 48, x= 272.87, y= 390.50),
    Intersection(halls= [], id= 49, x= 272.87, y= 392.24),
    Intersection(halls= [], id= 50, x= 239.06, y= 392.24),
    Intersection(halls= [], id= 51, x= 239.06, y= 390.50),
    Intersection(halls= [], id= 52, x= 239.06, y= 412.39),
    Intersection(halls= [], id= 53, x= 239.06, y= 381.25),
    Intersection(halls= [], id= 54, x= 234.42, y= 390.50),
    Intersection(halls= [], id= 55, x= 232.46, y= 365.55),
    Intersection(halls= [], id= 56, x= 227.54, y= 365.55),
    Intersection(halls= [], id= 57, x= 227.54, y= 356.48),
    Intersection(halls= [], id= 58, x= 227.54, y= 362.46),
    Intersection(halls= [], id= 59, x= 221.96, y= 362.46),
    Intersection(halls= [], id= 60, x= 210.59, y= 362.46),
    Intersection(halls= [], id= 61, x= 208.85, y= 353.93),
    Intersection(halls= [], id= 62, x= 208.85, y= 329.16),
    Intersection(halls= [], id= 63, x= 198.50, y= 353.93),
    Intersection(halls= [], id= 64, x= 146.67, y= 417.35),
    Intersection(halls= [], id= 65, x= 146.67, y= 412.46),
    Intersection(halls= [], id= 66, x= 188.13, y= 352.71),
    Intersection(halls= [], id= 67, x= 198.50, y= 352.71),
    Intersection(halls= [], id= 68, x= 165.73, y= 353.49),
    Intersection(halls= [], id= 69, x= 154.14, y= 353.49),
    Intersection(halls= [], id= 70, x= 147.04, y= 353.49),
    Intersection(halls= [], id= 71, x= 154.14, y= 387.88),
    Intersection(halls= [], id= 72, x= 166.76, y= 387.88),
    Intersection(halls= [], id= 73, x= 253.83, y= 390.50),
    Intersection(halls= [], id= 74, x= 220.90, y= 371.43),
    Intersection(halls= [], id= 75, x= 65.92, y= 387.13),
    Intersection(halls= [], id= 76, x= 119.10, y= 415.58),
    Intersection(halls= [], id= 77, x= 114.01, y= 415.58),
    Intersection(halls= [], id= 78, x= 154.92, y= 483.21),
    Intersection(halls= [], id= 79, x= 144.86, y= 493.77),
    Intersection(halls= [], id= 80, x= 119.53, y= 468.94),
    Intersection(halls= [], id= 81, x= 115.64, y= 464.98),
    Intersection(halls= [], id= 82, x= 119.53, y= 464.98),
    Intersection(halls= [], id= 83, x= 180.19, y= 468.94),
    Intersection(halls= [], id= 84, x= 190.87, y= 468.94),
    Intersection(halls= [], id= 85, x= 190.87, y= 462.93),
    Intersection(halls= [], id= 86, x= 218.07, y= 433.27),1
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
