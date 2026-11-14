from PIL import Image, ImageDraw
from pathlib import Path
import math

root = Path("android/app/src/main/res")
sizes = {"mdpi":48,"hdpi":72,"xhdpi":96,"xxhdpi":144,"xxxhdpi":192}
for density, n in sizes.items():
    folder = root / f"mipmap-{density}"
    folder.mkdir(parents=True, exist_ok=True)
    im = Image.new("RGBA", (n,n), (8,35,53,255))
    px = im.load()
    for y in range(n):
        for x in range(n):
            t = (x+y)/(2*n)
            px[x,y] = (int(5+4*t), int(48+66*t), int(65+15*t), 255)
    d = ImageDraw.Draw(im)
    m = int(n*.045)
    d.rounded_rectangle((m,m,n-m,n-m), radius=int(n*.22), outline=(255,178,26,255), width=max(2,int(n*.035)))
    # Monogram D: a bold rounded, open geometric mark.
    w = max(4,int(n*.115))
    d.line((int(n*.32),int(n*.25),int(n*.32),int(n*.75)), fill=(245,250,250,255), width=w)
    d.line((int(n*.32),int(n*.25),int(n*.52),int(n*.25)), fill=(245,250,250,255), width=w)
    d.arc((int(n*.34),int(n*.23),int(n*.78),int(n*.77)),270,90,fill=(245,250,250,255),width=w)
    # Circuit traces and nodes.
    for yy in (.42,.56,.69):
        y=int(n*yy)
        d.line((int(n*.12),y,int(n*.30),y),fill=(0,211,177,255),width=max(2,int(n*.025)))
        r=max(2,int(n*.035))
        d.ellipse((int(n*.12)-r,y-r,int(n*.12)+r,y+r),fill=(255,178,26,255))
    # Gold star/pixel motif.
    cx,cy=n*.77,n*.20
    points=[]
    for i in range(10):
        a=-math.pi/2+i*math.pi/5
        rad=n*(.095 if i%2==0 else .045)
        points.append((cx+math.cos(a)*rad,cy+math.sin(a)*rad))
    d.polygon(points,fill=(255,178,26,255))
    im.convert("RGB").save(folder/"ic_launcher.png", quality=95)
    im.save(folder/"ic_launcher_round.png")
