serveur_1 = 20
serveur_2 = 18

tache_1 = 120
tache_2 = 90

serveurs = [serveur_1, serveur_2]
taches = [tache_1, tache_2]

test_matrice = [
    [1, 2, 3, 4, 5],
    [1, 4, 2, 5, 3],
    [3, 2, 1, 5, 4],
    [1, 2, 3, 5, 4],
    [2, 1, 4, 3, 5]
]


def make_matrice(serveurs, taches):
    matrice = []
    for i in serveurs:
        ligne = []
        for j in taches:
            ligne.append(i * j)
        matrice.append(ligne)
    return matrice
        
#print(make_matrice(serveurs, taches))

def soustraction_ligne(matrice):
    index = -1
    for ligne in matrice:
        index+=1
        minimum = min(ligne)
        jindex = -1
        for colonne in ligne:
            jindex+=1
            matrice[index][jindex] -= minimum

    return matrice

def soustraction_colonne(matrice):
    nbColonnes = len(matrice[0])
    minColonne = []
    for i in range(nbColonnes):
        value = [min(i) for i in zip(*matrice)][i]
        minColonne.append(value)
    for ligne in range(len(matrice)):
        for colonne in range(len(matrice[ligne])):
            matrice[colonne][ligne] = matrice[colonne][ligne] - minColonne[ligne]
    return matrice

def encadrer_zeros(matrice):
    zero_encadre_indexes = []
    zero_barre_indexes = []
    lcounter = 0
    ccounter = 0
    lerror = False
    cerror = False
    for ligne in matrice:
        for colonne in ligne:
            if (colonne == 0):
                if (len(zero_encadre_indexes) == 0):
                    zero_encadre_indexes.append([lcounter, ccounter])
                else:
                    for i in zero_encadre_indexes:
                        if lcounter == i[0]:
                            lerror = True
                        if ccounter == i[1]:
                            cerror = True
                    if not lerror and not cerror:
                        zero_encadre_indexes.append([lcounter, ccounter])
                    else:
                        zero_barre_indexes.append([lcounter, ccounter])
                    lerror = False
                    cerror = False

            ccounter += 1
        ccounter = 0
        lcounter += 1
    return zero_encadre_indexes, zero_barre_indexes

def marquer_lignes_sans_zero_encadre(matrice, indexes):
    lignes = []
    lignes_zero = []
    for i in range(len(matrice)):
        lignes.append(i)
    for i in indexes:
        lignes_zero.append(i[0])
    return list(set(lignes).difference(lignes_zero))

def marquer_colonnes_avec_zero_barre_sur_ligne_marquee(indexes_barres, lignes_marques):
    colonne_marquees = []
    for barre in indexes_barres:
        for ligne in lignes_marques:
            if barre[0] == ligne:
                colonne_marquees.append(barre[1])
    return colonne_marquees

def marquer_lignes_avec_zero_encadre_sur_colonnes_marquee(indexes_encadres, colonnes_marques, lignes_marquees):
    for encadre in indexes_encadres:
        for colonne in colonnes_marques:
            if encadre[1] == colonne:
                lignes_marquees.append(encadre[0])
    return lignes_marquees

#print((make_matrice(serveurs, taches)))
#print(soustraction_colonne(soustraction_ligne(make_matrice(serveurs, taches))))
matrice = soustraction_colonne(soustraction_ligne(test_matrice))
zero_encadres, zero_barres = encadrer_zeros(matrice)
lignes_marquees = marquer_lignes_sans_zero_encadre(matrice, zero_encadres)
colonnes_marquees = marquer_colonnes_avec_zero_barre_sur_ligne_marquee(zero_barres, lignes_marquees)
lignes_marquees = marquer_lignes_avec_zero_encadre_sur_colonnes_marquee(zero_encadres, colonnes_marquees, lignes_marquees)
print(zero_encadres)
print(zero_barres)
print(lignes_marquees)
print(colonnes_marquees)


#encadrer_zeros(soustraction_colonne(soustraction_ligne(make_matrice(serveurs, taches))))