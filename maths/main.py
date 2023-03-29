import numpy as np
import sys
import random
np.set_printoptions(threshold=sys.maxsize)

def generate_auto_matrix(taillex, tailley, intervalle): # Génération automatique d'une matrice de taille variable avec des nombres variables
    matrice = np.random.randint(1, intervalle, size=(taillex, tailley)) # Nombre minimum = 1; Nombre maximum = intervalle, taille de la matrice défini par taillex et tailley
    return make_square_matrice(matrice)

def make_matrice(serveurs, taches): # Création d'une matrice en utilisant un lien entre array de serveurs et array de tâches
    matrice = []
    for i in serveurs: # Pour chaque serveur
        ligne = []
        for j in taches: # Pour chaque tâche qui va être effectuée sur le serveur
            ligne.append(i * j) # On ajoute le produit de la valeur du serveur et de la valeur de la tâche à la ligne de matrice (schématisation du travail nécessaire pour effectuer la tâche sur le serveur)
        matrice.append(ligne) # On ajoute la ligne à la matrice
    matrice = np.array(matrice) # On transforme la matrice en array numpy
    return make_square_matrice(matrice)

def make_square_matrice(matrice): # Création d'une matrice carrée en ajoutant des valeurs à la fin de la matrice
    if (len(matrice[0]) > len(matrice)): # Si le nombre de tâches est supérieur au nombre de serveurs
        print("Attention, la matrice n'est pas carrée, il y a plus de tâches que de serveurs : on rajoute des valeurs maximales à la fin de la matrice")
        for i in range(len(matrice[0]) - len(matrice)): # Pour chaque ligne à rajouter
            matrice = np.append(matrice, [[matrice.max()] * len(matrice[0])], axis=0) # On rajoute une ligne de valeurs maximales + 100
    elif (len(matrice[0]) < len(matrice)): # Si le nombre de tâches est inférieur au nombre de serveurs
        print("Attention, la matrice n'est pas carrée, il y a plus de serveurs que de tâches : on rajoute des valeurs maximales à la fin de la matrice")
        for i in range(len(matrice) - len(matrice[0])): # Pour chaque colonne à rajouter
            matrice = np.append(matrice, [[matrice.max() + 100] * len(matrice)], axis=1) # On rajoute une colonne de valeurs maximales + 100
    return matrice

def soustraction_ligne(matrice): # Soustraction de la valeur minimale de chaque ligne à chaque élément de la ligne
    index = -1
    for ligne in matrice: # Pour chaque ligne de la matrice
        index+=1
        minimum = min(ligne) # On récupère la valeur minimale de la ligne
        jindex = -1
        for colonne in ligne: # Pour chaque élément de la ligne (donc colonne)
            jindex+=1
            matrice[index][jindex] -= minimum # On soustrait la valeur minimale de la ligne à l'élément de la ligne

    return matrice

def soustraction_colonne(matrice): # Soustraction de la valeur minimale de chaque colonne à chaque élément de la colonne
    nbColonnes = len(matrice[0]) # Nombre de colonnes
    minColonne = []
    for i in range(nbColonnes): # Pour chaque colonne
        value = [min(i) for i in zip(*matrice)][i] # On récupère la valeur minimale de la colonne
        minColonne.append(value) # On ajoute la valeur minimale de la colonne à un array contenant chaque valeur minimale de chaque colonne
    for ligne in matrice.T: # Pour chaque ligne de la matrice transposée (donc colonne de la matrice originale)
        for colonne in ligne: # Pour chaque élément de la ligne (donc élément de la colonne sur la matrice originale)
            colonne -= minColonne # On soustrait la valeur minimale de la colonne à l'élément de la colonne
    return matrice

def encadrer_zeros(matrice): # Encadrement des zéros de la matrice
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


def griser_les_lignes_et_colonnes(lignes_marquees, colonnes_marquees, matrice): # Grise les lignes et colonnes selon les lignes et colonnes marquées
    lignes = []
    for ligne in range(len(matrice)): # Pour chaque ligne de la matrice
        lignes.append(ligne) # On ajoute le numéro de ligne dans la liste des lignes
    lignes_grisees = list(set(lignes).difference(lignes_marquees)) # Les lignes grisées sont l'inverse des lignes marquées
    
    colonnes_grisee = colonnes_marquees # Les colonnes grisées sont les colonnes marquées
    return colonnes_grisee, lignes_grisees # Return

def colonnes_non_grisees(matrice, colonnes_grisees): # Trouve les colonnes non grisées
    colonnes = []
    ccounter = 0
    for ligne in matrice: # Pour chaque ligne de la matrice
        for colonne in ligne: # Pour chaque élément de la ligne
            colonnes.append(ccounter) # On ajoute le numéro de colonne dans la liste des colonnes
            ccounter += 1
    return list(set(colonnes).difference(colonnes_grisees)) # Les lignes non grisées sont l'inverse des lignes grisées

def find_min(matrice, lignes_marquees, colonnes_grisees): # Trouve le minimum de tous les éléments n'étant pas sur une ligne grisée
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    colonnes_non_grisee = colonnes_non_grisees(matrice, colonnes_grisees) # On récupère les colonnes non grisées
    if (len(lignes_marquees) == 0): # Si aucune ligne n'est marquée
        minimum = 0 # Pas de minimum, la matrice est donc déjà optimale. On utilise zéro pour ne pas impacter le résultat
    else: # Sinon
        minimum = matrice[min(lignes_marquees)][min(colonnes_non_grisee)] # On initialise le minimum avec le premier élément non grisé
    for ligne in matrice: # Pour chaque ligne de la matrice
        for colonne in ligne: # Pour chaque élément de la ligne
            if (lcounter in lignes_marquees) and (ccounter not in colonnes_grisees): # Si ligne et colonnes ne sont pas grisées
                if (colonne < minimum): # Et si l'élément actuel est plus petit que le minimum
                    minimum = colonne # On met à jour le minimum
            ccounter += 1 # Colonne suivante (élément suivant)
        ccounter = 0 # Reset de variable
        lcounter += 1 # Ligne suivante
    return minimum # On retourne le minimum

def soustraire_min_non_grise(matrice, colonnes_grisees, lignes_grisees, lignes_marquees): # Soustrait le minimum de tous les éléments n'étant pas sur une case grisée
    min = find_min(matrice, lignes_marquees, colonnes_grisees) # On récupère le minimum des cases non grisées
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    for ligne in matrice: # Pour chaque ligne de la matrice
        for colonne in ligne: # Pour chaque élément de la ligne
            if (lcounter in lignes_grisees) and (ccounter in colonnes_grisees): # Si ligne et colonnes sont grisées (case doublement grisée)
                matrice[lcounter][ccounter] += min # On ajoute le minimum
            if (lcounter in lignes_marquees) and (ccounter not in colonnes_grisees): # Si case non grisée
                matrice[lcounter][ccounter] -= min # On soustrait le minimum
            ccounter += 1 # Colonne suivante (élément suivant)
        ccounter = 0 # Reset de variable
        lcounter += 1 # Ligne suivante
    return matrice # On retourne la matrice modifiée

def choose_serveurs_taches(matrice): # On attribue les tâches aux serveurs	
    links = [] # Liste contenant l'attribution entre serveurs et tâches
    erreur = False
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne

    zeros = np.argwhere(matrice == 0) # On récupère les coordonnées des zéros de la matrice

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

    # Pour les lignes ayant plus de un 0, sélectionner celles dont les colonnes ont un seul 0
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

    lignes_barres = [] # Liste des lignes ayant déjà un 0 sélectionné (serveur-tâche déjà attribué)
    colonnes_barres = [] # Liste des colonnes ayant déjà un 0 sélectionné (serveur-tâche déjà attribuée)

    for selected in links: # Pour chaque lien déjà établi entre serveur et tâche
        lignes_barres.append(selected[0]) # On ajoute la ligne et la colonne à la liste des lignes et colonnes déjà sélectionnées
        colonnes_barres.append(selected[1])

    # L'idée du code ci-après est de sélectionner pour chaque 0 restant celui qui a le moins de possibilités de sélection (le moins de conflits : le moins de 0 sur la même colonne)
    lcounter = 0 # Compteur de ligne
    ccounter = 0 # Compteur de colonne
    for ligne in matrice: # Pour chaque ligne de la matrice
        counter = {}
        for colonne in ligne: # Pour chaque élément de la ligne
            if colonne == 0: # Si le nombre vaut 0
                count = 0
                for position in zeros.tolist(): # Pour chaque zéro de la matrice
                    if (ccounter == position[1]): # Si la colonne du zéro correspond à la colonne actuelle (sélection )
                        if (position[1] not in colonnes_barres) and (position[0] not in lignes_barres): # Si la ligne et la colonne du zéro ne sont pas déjà sélectionnées
                            if (lcounter != position[0]): # Si la ligne du zéro n'est pas la ligne actuelle
                                count += 1 # C'est un conflit (un 0 non sélectionné sur la même colonne)
                        counter[ccounter] = count # On associe le nombre de conflits à la colonne pour un zéro sur cette ligne
            ccounter += 1 # Augmentation compteur colonne
        if len(counter) != 0: # Si il y a des conflits sur ce zéro
            if (lcounter not in lignes_barres) and (min(counter, key = counter.get) not in colonnes_barres): # Si la ligne et la colonne du zéro ne sont pas déjà sélectionnées
                if ([lcounter, min(counter, key = counter.get)] not in links): # Et si le lien n'est pas déjà sélectionné
                    links.append([lcounter, min(counter, key = counter.get)]) # On ajoute le lien
                if (lcounter not in lignes_barres): # Si la ligne n'est pas déjà sélectionnée
                    lignes_barres.append(lcounter) # On "sélectionne" la ligne
                if (min(counter, key = counter.get) not in colonnes_barres): # Si la colonne n'est pas déjà sélectionnée
                    colonnes_barres.append(min(counter, key = counter.get)) # On "sélectionne" la colonne
        ccounter = 0 # Reset de la colonne
        lcounter += 1 # Changement de ligne


    # Dans ce dernier morceau de code, on sélectionne les valeurs restantes (pas forcément 0, sur les lignes et colonnes qui n'ont pas encore été sélectionnées), en prenant les valeurs les plus faibles
    lignes = []
    for i in range(len(matrice)): # Pour chaque ligne de la matrice
        lignes.append(i) # On ajoute le numéro de la ligne à la liste des lignes
    colonnes = [] # De même pour les colonnes
    for i in range(len(matrice[0])):
        colonnes.append(i)
    for couple in links: # Pour chaque lien déjà sélectionné
            if (couple[0] in lignes_barres): # Si la ligne du lien est déjà sélectionnée
                lignes.remove(couple[0]) # On retire la ligne de la liste des lignes à sélectionner
            if (couple[1] in colonnes_barres): # Si la colonne du lien est déjà sélectionnée
                colonnes.remove(couple[1]) # On retire la colonne de la liste des colonnes à sélectionner
    while len(lignes) != 0 and len(colonnes) != 0: # Tant qu'il reste des lignes et des colonnes à sélectionner
        elements = {}
        for ligne in lignes: # On étudie ligne à ligne
            for colonne in colonnes: # Pour chaque élément de la ligne restante
                elements[matrice[ligne][colonne]] = [ligne,colonne] # On enregistre dans un dictionnaire la valeur de la matrice pour cette ligne et colonne, et une liste contenant la ligne et la colonne
        res = elements[min(elements)] # On sélectionne la valeur la plus faible pour la ligne étudiée
        links.append(res) # On ajoute le lien minimum
        lignes.remove(res[0]) # On retire la ligne et la colonne de la liste des lignes et colonnes à sélectionner
        colonnes.remove(res[1])
    return links # On a fait tous les liens de manière optimale, on retourne la liste des liens

def print_serveurs_taches(links, size_serveurs): # Fonction qui affiche les liens serveurs-tâches
    for link in links: # Pour chaque lien
        if (int(link[0]) > size_serveurs): # Comme on a parfois ajouté des serveurs (matrice non carrée), on vérifie si le serveur est un serveur "virtuel" ajouté
            print("La serveur "+ str(int(link[0] - size_serveurs)) + " prend la tache " + str(int(link[1])) + " avec un temps de " + str(int(matrice[int(link[0])][int(link[1])]))) # Si c'est le cas, on affiche ce lien sur un serveur réel
        else: # Sinon, on affiche le lien sur un serveur réel
            print("Le serveur "+ str(int(link[0])) + " prend la tache " + str(int(link[1])) + " avec un temps de " + str(int(matrice[int(link[0])][int(link[1])])))

ERR = False
count = 1
while not ERR:
    # Sélection de méthode
    #type = int(input("Quelle méthode voulez-vous :\n 1) Matrice auto-générée\n 2) Matrice de lien serveurs - tâches\n 3) Matrice pré-configurée\nChoisissez avec le nombre précédant la commande\n"))
    type = 2
    if type == 1: # Cas ou la matrice est auto-générée aléatoirement en fonction de la taille voulue et de l'intervalle de valeurs
        serveur_count = int(input("Quelle est la taille horizontale de la matrice que vous voulez (entrez un nombre) : "))
        taches_count = int(input("Quelle est la taille verticale de la matrice que vous voulez (entrez un nombre) : "))
        intervalle = int(input("Quelle est le nombre maximal dans la matrice (entrez un nombre) : "))
        matrice = generate_auto_matrix(serveur_count, taches_count, intervalle)
        print("La matrice auto-générée est : \n" + str(matrice))
    elif type == 2: # Cas ou la matrice est générée en fonction des valeurs entrées par l'utilisateur pour chaque serveur et chaque tâche
        serveurs = []
        #serveur_count = int(input("Combien y a-t-il de serveurs (entrez un nombre N >= 1) ? \n"))
        #for i in range(0, serveur_count):
        #   valeur = int(input("Valeur du serveur "+ str(i) +" : "))
        #   while valeur <= 0:
        #       print("La valeur doit être comprise entre 1 et N >= 1")
        #       valeur = int(input("Valeur du serveur "+ str(i) +" : "))
        #   serveurs.append(valeur)
        taches = []
        #taches_count = int(input("Combien y a-t-il de tâches (entrez un nombre N >= 1) ? \n"))
        #for i in range(0, taches_count):
        #    valeur = int(input("Valeur de la tâche "+ str(i) +" : "))
        #    while valeur <= 0:
        #        print("La valeur doit être comprise entre 1 et N >= 1")
        #        valeur = int(input("Valeur de la tâche "+ str(i) +" : "))
        #    taches.append(valeur)
        for i in range(7):
            serveurs.append(random.randint(1, 80000))
        for i in range(10):
            taches.append(random.randint(1, 80000))
        matrice = make_matrice(serveurs, taches)
        #print("La matrice liée tâches-serveurs est : \n" + str(matrice))
    else: # Cas ou la matrice est pré-configurée
        matrice = np.array([
            [100, 300, 140, 250, 120,  90,  40, 120, 130, 170],
            [ 50, 150,  70, 125,  60,  45,  20,  60,  65,  85],
            [ 70, 210,  98, 175,  84,  63,  28,  84,  91, 119],
            [150, 450, 210, 375, 180, 135,  60, 180, 195, 255],
            [ 60, 180,  84, 150,  72,  54,  24,  72,  78, 102],
            [ 90, 270, 126, 225, 108,  81,  36, 108, 117, 153]
        ])

    # Sélection de mode d'affichage
    #mode = int(input("Voulez-vous le mode :\n 1) Pas à pas (arrêt entre chaque opération)\n 2) Résultat (calcul direct du résultat)\nChoisissez avec le nombre précédant la commande\n"))
    mode = 2
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
    #print("La matrice finale : \n" + str(matrice_finale))
    links = choose_serveurs_taches(matrice_finale)
    if (len(links) != 10 or len(links) != 10):
            print(str(links) + " : \n" + str(matrice_finale))
            print_serveurs_taches(links, 7)
            print("Erreur : le nombre de serveurs et de tâches ne correspond pas à la matrice " + str(count))
            input()
    print("Réussite de la matrice " + str(count))
    count += 1
    #print_serveurs_taches(links, 7)