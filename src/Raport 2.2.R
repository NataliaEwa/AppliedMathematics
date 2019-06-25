

Akcja=movies$rating[movies$Action==1]
Komedia=movies$rating[movies$Comedy==1] 
Dramat=movies$rating[movies$Drama==1]
Romans=movies$rating[movies$Romance==1]
Krotki=movies$rating[movies$Short==1]
Animacja=movies$rating[movies$Animation==1]
Dokument=movies$rating[movies$Documentary==1]


var.test(Akcja, Komedia) # czy jest jednorodność wariancji?
var.test(Komedia, Dramat)
var.test(Dramat, Romans)
var.test(Romans, Krotki)
var.test(Krotki, Animacja)
var.test(Animacja, Dokument)

var.test(Dramat, Krotki)

# jeśli nie ma różnic wariancji przeprowadzamy test t.Studenta
# alfa = 0.05
t.test(Akcja, Komedia, mu=0, var.equal=TRUE, alternative = "less")
t.test(Komedia, Dramat, mu=0, var.equal=TRUE, alternative = "less")
t.test(Dramat, Romans, mu=0, var.equal=TRUE, alternative = "less")
t.test(Romans, Krotki, mu=0, var.equal=TRUE, alternative = "less")
t.test(Krotki, Animacja, mu=0, var.equal=TRUE, alternative = "less")
t.test(Animacja, Dokument, mu=0, var.equal=TRUE, alternative = "less")

t.test(Dramat, Krotki, mu=0, var.equal=TRUE, alternative = "less")
# alfa = 0.01
t.test(Akcja, Komedia, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.90)
t.test(Komedia, Dramat, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.99)
t.test(Dramat, Romans, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.99)
t.test(Romans, Krotki, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.99)
t.test(Krotki, Animacja, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.99)
t.test(Animacja, Dokument, mu=0, var.equal=TRUE, alternative = "less", conf.level=0.99)

# jeśli wariancje są różne przeprowadzamy test Wilcoxona

wilcox.test(d1,d2)

przedzial(Akcja, conf.level=0.99)
przedzial(Komedia, conf.level=0.99)
przedzial(Dramat, conf.level=0.99)
przedzial(Romans, conf.level=0.99)
przedzial(Krotki, conf.level=0.99)
przedzial(Animacja, conf.level=0.99)
przedzial(Dokument, conf.level=0.99)



