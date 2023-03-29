import numpy as np
import sys
import time
np.set_printoptions(threshold=sys.maxsize)

def generate_auto_matrix(taillex, tailley, intervalle): # Génération automatique d'une matrice de taille variable avec des nombres variables
    return np.random.randint(1, intervalle, size=(taillex, tailley)) # Nombre minimum = 1; Nombre maximum = intervalle, taille de la matrice défini par taillex et tailley

def make_matrice(serveurs, taches): # Création d'une matrice en utilisant un lien entre array de serveurs et array de tâches
    matrice = []
    for i in serveurs:
        ligne = []
        for j in taches:
            ligne.append(i * j)
        matrice.append(ligne)
    return np.array(matrice)

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

def marquer_colonnes_avec_zero_barre_sur_ligne_marquee(indexes_barres, lignes_marques, colonnes_marquees):
    for barre in indexes_barres: # Pour chaque zéro barré
        for ligne in lignes_marques: # Pour chaque ligne déjà marquée
            if (barre[0] == ligne) and (barre[0] not in colonnes_marquees): # Si la ligne du zéro barré est égale à la ligne marquée, il faut marquer la colonne du zéro barré
                colonnes_marquees.append(barre[1]) # Ajout colonne
    return colonnes_marquees # Return

def marquer_lignes_avec_zero_encadre_sur_colonnes_marquee(indexes_encadres, colonnes_marques, lignes_marquees):
    for encadre in indexes_encadres: # Pour chaque zéro encadré
        for colonne in colonnes_marques: # Pour chaque colonne marquée
            if encadre[1] == colonne and (encadre[0] not in lignes_marquees): # Si un zéro encadré appartient à une colonne marquée
                lignes_marquees.append(encadre[0]) # On marque la ligne à laquelle appartient le zéro encadré
    return lignes_marquees # Return 


def griser_les_lignes_et_colonnes(lignes_marquees, colonnes_marquees, matrice):
    lignes = []
    for ligne in range(len(matrice)):
        lignes.append(ligne)
    lignes_grisees = list(set(lignes).difference(lignes_marquees))
    
    colonnes_grisee = colonnes_marquees
    return colonnes_grisee, lignes_grisees

def colonnes_non_grisees(matrice, colonnes_grisees):
    colonnes = []
    ccounter = 0
    for ligne in matrice:
        for colonne in ligne:
            colonnes.append(ccounter)
            ccounter += 1
    return list(set(colonnes).difference(colonnes_grisees))

def find_min(matrice, lignes_marquees, colonnes_grisees):
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    colonnes_non_grisee = colonnes_non_grisees(matrice, colonnes_grisees)
    if (len(lignes_marquees) == 0):
        minimum = 0
    else:
        minimum = matrice[min(lignes_marquees)][min(colonnes_non_grisee)]
    for ligne in matrice:
        for colonne in ligne:
            if (lcounter in lignes_marquees) and (ccounter not in colonnes_grisees):
                if (colonne < minimum):
                    minimum = colonne
            ccounter += 1 # Colonne suivante (élément suivant)
        ccounter = 0 # Reset de variable
        lcounter += 1 # Ligne suivante
    return minimum 

def soustraire_min_non_grise(matrice, colonnes_grisees, lignes_grisees, lignes_marquees):
    min = find_min(matrice, lignes_marquees, colonnes_grisees)
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    for ligne in matrice:
        for colonne in ligne:
            #print("Lc = "+str(lcounter)+"; cc = " + str(ccounter) + "; lignes grisées = " + str(lignes_grisees) + "; colonnes grisées = "+ str(colonnes_grisees))
            if (lcounter in lignes_grisees) and (ccounter in colonnes_grisees):
                matrice[lcounter][ccounter] += min
            if (lcounter in lignes_marquees) and (ccounter not in colonnes_grisees):
                matrice[lcounter][ccounter] -= min
            ccounter += 1 # Colonne suivante (élément suivant)
        ccounter = 0 # Reset de variable
        lcounter += 1 # Ligne suivante
    return matrice

def choose_serveurs_taches(matrice):
    links = []
    erreur = False
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne

    zeros = np.argwhere(matrice == 0)

    # Les lignes ayant un seul 0 peuvent directement être séléctionnés (seul choix possible)
    for ligne in matrice:
        if (np.count_nonzero(ligne == 0) == 1): # Chercher les lignes ayant seulement un zéro (ligne == 0) retourne le nombre de fois qu'un argument vaut zéro dans la ligne, on cherche celles ou il n'y en à qu'un
            for colonne in ligne: # Itération sur la ligne
                if colonne == 0: # Si le nombre vaut 0
                    erreur = False # Reset de variable
                    for selected in links: # Pour chaque lien déjà établi
                        if (lcounter == selected[0]) or (ccounter == selected[1]): # Vérifier si la ligne de lien correspond à la ligne du nombre actuel, de même pour la colonne
                            erreur = True # Si c'est le cas, un 0 a déjà été sélectionné sur une même ligne ou colonne ce 0 ne peut pas être sélectionné
                    if not erreur: # Pas d'erreur
                        links.append([lcounter, ccounter]) # On peut choisir ce 0 comme lien entre serveur et machine
                ccounter += 1 # Augmentation compteur colonne
        ccounter = 0 # Reset de la colonne
        lcounter += 1 # Changement de ligne
    lcounter = 0 # Reset du compteur de ligne

    # Pour les colonnes ayant plus de un 0, sélectionner celles dont les colonnes ont un seul 0
    for colonne in matrice.T: # Transoposition de la matrice pour en obtenir les colonnes
        if (np.count_nonzero(colonne == 0) == 1): # Chercher les colonnes ayant seulement un seul 0
            for valeur in colonne: # Pour chaque valeur dans la colonne
                if valeur == 0: # Si la valeur est égale à 0 (ne devrait être appelé qu'une fois)
                    erreur = False # Reset de variable
                    for selected in links: # Pour chaque lien déjà établi
                        if (ccounter == selected[0]) or (lcounter == selected[1]): # Vérifier si la ligne de lien correspond à la ligne du nombre actuel, de même pour la colonne
                            erreur = True # Si c'est le cas, un 0 a déjà été sélectionné sur une même ligne ou colonne ce 0 ne peut pas être sélectionné
                    if not erreur: # Pas d'erreur
                        links.append([ccounter, lcounter]) # /!\ inversion entre ccounter et lcounter voulue, car nous travaillons dans la transposée de la matrice
                ccounter += 1 # Augmentation compteur colonne
        ccounter = 0 # Reset de la colonne
        lcounter += 1 # Changement de ligne
    lcounter = 0  # Reset du compteur de ligne

    lignes_barres = []
    colonnes_barres = []

    print(links)

    for selected in links:
        lignes_barres.append(selected[0])
        colonnes_barres.append(selected[1])

    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    for ligne in matrice:
        counter = {}
        for colonne in ligne:
            if colonne == 0:
                count = 0
                for position in zeros.tolist():
                    #print(position)
                    #print(str(lcounter) + " : " + str(ccounter))
                    if (ccounter == position[1]):
                        if (position[1] not in colonnes_barres) and (position[0] not in lignes_barres):
                            if (lcounter != position[0]):
                                count += 1
                        counter[ccounter] = count
            ccounter += 1 # Augmentation compteur colonne
        print(lignes_barres)
        print(colonnes_barres)
        print(counter)
        if len(counter) != 0:
            if (lcounter not in lignes_barres) and (min(counter, key = counter.get) not in colonnes_barres):
                if ([lcounter, min(counter, key = counter.get)] not in links):
                    links.append([lcounter, min(counter, key = counter.get)])
                if (lcounter not in lignes_barres):
                    lignes_barres.append(lcounter)
                if (min(counter, key = counter.get) not in colonnes_barres):
                    colonnes_barres.append(min(counter, key = counter.get))
        print("Liens : " +str(links) + "\n")
        ccounter = 0 # Reset de la colonne
        lcounter += 1 # Changement de ligne

        
    
    return links

def print_serveurs_taches(links):
    print(links)
    for link in links:
        print("Le serveur "+ str(int(link[0])) + " prend la tache " + str(int(link[1])))

type = int(input("Quelle méthode voulez-vous :\n 1) Matrice auto-générée\n 2) Matrice de lien serveurs - tâches\n 3) Matrice pré-configurée\nChoisissez avec le nombre précédant la commande\n"))
erreur = False
if type == 1:
    taillex = int(input("Quelle est la taille horizontale de la matrice que vous voulez (entrez un nombre) : "))
    tailley = int(input("Quelle est la taille verticale de la matrice que vous voulez (entrez un nombre) : "))
    intervalle = int(input("Quelle est le nombre maximal dans la matrice (entrez un nombre) : "))
    matrice = generate_auto_matrix(taillex, tailley, intervalle)
    print("La matrice auto-générée est : \n" + str(matrice))
elif type == 2:
    serveurs = []
    serveur_count = int(input("Combien y a-t-il de serveurs (entrez un nombre N >= 1) ? \n"))
    for i in range(0, serveur_count):
        valeur = int(input("Valeur du serveur "+ str(i) +" : "))
        while valeur <= 0:
            print("La valeur doit être comprise entre 1 et N >= 1")
            valeur = int(input("Valeur du serveur "+ str(i) +" : "))
        serveurs.append(valeur)
    taches = []
    taches_count = int(input("Combien y a-t-il de tâches (entrez un nombre N >= 1) ? \n"))
    for i in range(0, taches_count):
        valeur = int(input("Valeur de la tâche "+ str(i) +" : "))
        while valeur <= 0:
            print("La valeur doit être comprise entre 1 et N >= 1")
            valeur = int(input("Valeur de la tâche "+ str(i) +" : "))
        taches.append(valeur)
    matrice = make_matrice(serveurs, taches)
    print("La matrice liée tâches-serveurs est : \n" + str(matrice))
else:
    matrice = np.array([
        [5, 3, 1, 1, 6],
        [7, 7, 5, 8, 7],
        [9, 3, 9, 8, 9],
        [8, 3, 4, 3, 1],
        [2, 1, 3, 9, 9]
    ])

mode = int(input("Voulez-vous le mode :\n 1) Pas à pas (arrêt entre chaque opération)\n 2) Résultat (calcul direct du résultat)\nChoisissez avec le nombre précédant la commande\n"))

if not erreur:   
    matrice = soustraction_colonne(soustraction_ligne(matrice))
    if (mode == 1):
        print("Après soustraction en lignes et colonnes, la matrice est : \n" + str(matrice))
        input("Appuyez sur entrer pour continuer\n\n")

    zero_encadres, zero_barres = encadrer_zeros(matrice)
    if (mode == 1):
        print("Les zéros encadrés : " + str(zero_encadres))
        print("Les zéros barrés : " + str(zero_barres))
        input("Appuyez sur entrer pour continuer\n\n")


    lignes_marquees = marquer_lignes_sans_zero_encadre(matrice, zero_encadres)
    change = True
    lignes_marquees_before = []
    colonnes_marquees_before = []
    while change:
        colonnes_marquees = []

        colonnes_marquees = marquer_colonnes_avec_zero_barre_sur_ligne_marquee(zero_barres, lignes_marquees, colonnes_marquees)
        if (mode == 1):
            print("Les colonnes marquées : " + str(colonnes_marquees))
            input("Appuyez sur entrer pour continuer\n\n")


        lignes_marquees = marquer_lignes_avec_zero_encadre_sur_colonnes_marquee(zero_encadres, colonnes_marquees, lignes_marquees)
        if (mode == 1):
            print("Les lignes marquées : " + str(lignes_marquees))
            input("Appuyez sur entrer pour continuer\n\n")
    
        print(str(lignes_marquees) + ":" + str(lignes_marquees_before))
        print(str(len(lignes_marquees_before) == len(lignes_marquees)) +" + "+ str(len(colonnes_marquees_before) == len(colonnes_marquees)))
        if (len(lignes_marquees_before) == len(lignes_marquees)) and (len(colonnes_marquees_before) == len(colonnes_marquees)):
            change = False
        else:
            lignes_marquees_before = lignes_marquees.copy()
            colonnes_marquees_before = colonnes_marquees.copy()

    colonnes_grisees, lignes_grisees = griser_les_lignes_et_colonnes(lignes_marquees, colonnes_marquees, matrice)
    if (mode == 1):
        print("Les colonnes grisées : " + str(colonnes_grisees))
        print("Les lignes grisées : " + str(lignes_grisees))
        input("Appuyez sur entrer pour continuer\n\n")


    matrice_finale = soustraire_min_non_grise(matrice, colonnes_grisees, lignes_grisees, lignes_marquees)
    print("La matrice finale : \n" + str(matrice_finale))
    links = choose_serveurs_taches(matrice_finale)
    print_serveurs_taches(links)