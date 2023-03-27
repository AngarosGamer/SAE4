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
    zero_encadre_indexes = [] # Les zéros encadrés
    zero_barre_indexes = [] # Les zéros barrés
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    lerror = False # Le zéro trouvé est-il sur une ligne où un zéro est encadré
    cerror = False # Le zéro trouvé est-il sur une colonne où un zéro est encadré
    for ligne in matrice: # Parcours des lignes
        for colonne in ligne: # Pour chaque élément de la ligne (donc colonne)
            if (colonne == 0): # Si l'élément est un zéro
                if (len(zero_encadre_indexes) == 0): # Si c'est le premier zéro à être trouvé
                    zero_encadre_indexes.append([lcounter, ccounter]) # Le zéro peut être directement encadré
                else: # Pas le premier zéro à être trouvé
                    for i in zero_encadre_indexes: # Pour chacun des zéros déjà encadrés
                        if lcounter == i[0]: # Si le zéro actuel appartient à une ligne déjà encadrée
                            lerror = True # Erreur, le zéro doit être barré
                        if ccounter == i[1]: # Si le zéro actuel appartient à une colonne déjà encadrée
                            cerror = True # Erreur, le zéro doit être barré
                    if not lerror and not cerror: # Pas d'erreur, le zéro peut être encadré (il n'est pas sur une ligne où colonne ayant un zéro encadré)
                        zero_encadre_indexes.append([lcounter, ccounter])
                    else: # Erreur, le zéro est sur une ligne ou colonne possédant un zéro déjà encadré
                        zero_barre_indexes.append([lcounter, ccounter])
                    lerror = False # Reset de variable
                    cerror = False

            ccounter += 1 # Colonne suivante (élément suivant)
        ccounter = 0 # Reset de variable
        lcounter += 1 # Ligne suivante
    return zero_encadre_indexes, zero_barre_indexes # Retour des positions des zéros encadrés et zéros barrés

def marquer_lignes_sans_zero_encadre(matrice, indexes):
    lignes = []
    lignes_zero = []
    for i in range(len(matrice)): # Pour chaque ligne dans la matrice
        lignes.append(i) # On ajoute le numéro de ligne dans la liste des lignes
    for i in indexes: # Pour chaque index de zéro encadré
        lignes_zero.append(i[0]) # On rajoute la ligne de ce zéro encadré
    return list(set(lignes).difference(lignes_zero)) # On retourne la différence entre la liste des lignes et la liste des lignes ayant un zéro encadré (soit les listes n'ayant pas de zéro encadré)

def marquer_colonnes_avec_zero_barre_sur_ligne_marquee(indexes_barres, lignes_marques):
    colonne_marquees = []
    for barre in indexes_barres: # Pour chaque zéro barré
        for ligne in lignes_marques: # Pour chaque ligne déjà marquée
            if barre[0] == ligne: # Si la ligne du zéro barré est égale à la ligne marquée, il faut marquer la colonne du zéro barré 
                colonne_marquees.append(barre[1]) # Ajout colonne
    return colonne_marquees # Return

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