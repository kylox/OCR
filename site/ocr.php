<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>CamlT'OCR - OCR</title>
		<link rel="stylesheet" href="style.css" type="text/css"/>
		
	</head>
	
<body>
		<!-- = Menu				  = -->
     
		<?php include("menu.php");?> 
		
			<!-- = Fin Menu = -->
			
			<!-- = Main Page		  = -->
			
	<div id="body">
       <?php include("header.php");?> 
			
                <!-- = Content = -->
 <h1>Projet CamlT'OCR </h1><br/>
                    <h2>Vous avez dit OC-quoi ??</h2>
<hr style="border:none; border-bottom:dashed #006699 1px;"/>
La reconnaissance optique de caracteres, ou encore appel'e vid'eocodage designe les procedes informatiques pour la traduction d'images de textes imprimes ou dactylographies en fichiers de texte. Elle realise beaucoup moins que l'etre humain qui, lui, execute, en plus de la reconnaissance, la comprehension du message, sa memorisation, voire son analyse critique dans un seul temps.

Un ordinateur reclame pour l'execution de cette tache un logiciel de ROC. Celui-ci permet de recuperer le texte dans l'image d'un texte imprime et de le sauvegarder dans un fichier pouvant etre exploite dans un traitement de texte pour enrichissement, et stocke dans une base de donnees ou du moins, sur un support sur et exploitable par un systeme informatique.

Un systeme ROC part de l'image numerique realisee par un scanner optique d'une page (document imprime, feuillet dactylographie, etc.), ou une camera numerique, et produit en sortie un fichier texte en divers formats (texte simple, formats de traitements de texte, XML...).

Certains logiciels tentent de conserver l'enrichissement du texte (corps, graisse et police) ainsi que la mise en page, voire de rebatir les tableaux et d'extraire les images.

Certains logiciels comportent, en outre, une interface pour l'acquisition num'erique de l'image.

Jusqu'a une date recente, le fonctionnement des systemes ROC performants etait peu connu car protege par le secret industriel ; les logiciels open-source disponibles (ex : GOcr) etant plutot l'oeuvre d'amateurs. La publication en open-source de systemes performants (en particulier Tesseract en 2006) a quelque peu change cette situation.

Les etapes de traitement peuvent etre schematisees ainsi :

    Pre-analyse de l'image : le but est d'ameliorer eventuellement la qualite de l'image. Ceci peut inclure le redressement d'images inclinees ou deformees, des corrections de contraste, le passage en mode bicolore (noir et blanc, ou plutot papier et encre), la detection de contours.
            Segmentation en lignes et en caracteres (ou Analyse de page) : vise a isoler dans l'image les lignes de texte et les caracteres a l'interieur des lignes. Cette phase peut aussi d'etecter le texte souligne, les cadres, les images.
            Reconnaissance pr2oprement dite des caracteres : apres normalisation (echelle, inclinaison), une instance a reconnaitre est comparee a une bibliotheque de formes connues, et on retient pour l'etape suivante la forme la plus  proche  (ou les N formes les plus proches), selon une distance ou une vraisemblance (likelihood)
<hr style ="border:none;border-bottom:dashed #006699 1px;"/>
<div style="float:right; padding-left:15px1; text-align:center;">
	
  <a href="?url=downloads" style="border:none; text-decoration:none;"></a></div>
  <p class="justify"><br /> </p>
  <p class="justify"></p>
</div>
                    
            
		<!-- = Footer			  = -->
	<div id="footer">
		<div class="footer">
			<ul>
				<li><a href="main.php" title="Home" class="hover">home</a></li>
				<li><a href="ocr.php" title="ocr.">OCR</a></li>
				<li><a href="team.php" title="team.">Team</a></li>
				<li><a href="downloads.php" title="downloads">Téléchargement</a></li>
			</ul></br>
		<p>The world is mine</p>
	</div>
	</div>
        
</body>
</html>
