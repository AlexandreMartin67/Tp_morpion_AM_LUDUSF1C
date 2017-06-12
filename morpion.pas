PROGRAM morpion;

uses crt , graph;

TYPE
	choix_case = 1..9;

TYPE
	cases = record
		croix : boolean;
		rond : boolean;
End;

TYPE
	joueur = record
		actif : boolean;
		nom : string;
		nb_partie_win : integer;
End;

TYPE
	tableau_cases = array [1..3,1..3] of cases ;

TYPE
	tableau_cases_utiliser = array [1..9] of boolean;

procedure affichage(tab_cases : tableau_cases);

	Var
		i,j : integer;
	Begin
		SetColor(white);
		line(0,100,300,100);
		line(0,200,300,200);
		line(100,0,100,300);
		line(200,0,200,300); // affiche la grille du morpion

		line(300,350,450,350);
		line(300,400,450,400);
		line(350,300,350,450);
		line(400,300,400,450); // affiche une petite grille de morpion
		OutTextXY (325,325,'1');
		OutTextXY (325,375,'2');
		OutTextXY (325,425,'3');
		OutTextXY (375,325,'4');
		OutTextXY (375,375,'5');
		OutTextXY (375,425,'6');
		OutTextXY (425,325,'7');
		OutTextXY (425,375,'8');
		OutTextXY (425,425,'9');


		For i:=1 To 3 Do
			For j:=1 To 3 Do
				Begin
					If tab_cases[i,j].croix = true Then
						Begin
							SetColor(Red);
							line((i-1)*100+10,(j-1)*100+10,i*100-10,j*100-10);
							line(i*100-10,(j-1)*100+10,(i-1)*100+10,j*100-10);
						End;
					If  tab_cases[i,j].rond = true Then
						Begin
							SetColor(Blue);
							circle(i*100-50,j*100-50,40);
						End;
				End;
	End;


function verif_case_vide(case_select : integer ;var tab_cases_utiliser : tableau_cases_utiliser) : boolean;

	Var
		test : boolean;
	Begin

		If (tab_cases_utiliser[case_select]) Then
			test := false
		else
			begin
				test := true;
				tab_cases_utiliser[case_select]:=true;
			end;
		verif_case_vide:=test;
	End;

function verif_victoire_croix(tab_cases : tableau_cases) : boolean;

	Var

		i,j :integer;
		victoire_croix : boolean;

	Begin
		victoire_croix := false;
		for j := 1 to 3 do
			Begin
				for i := 1 to 3 do
					Begin
						if ((i = 1) and (j = 1))then
							begin
								if (tab_cases[i,j].croix) and (tab_cases[i+1,j].croix) and (tab_cases[i+2,j].croix) then
									victoire_croix:=true
								else
									if (tab_cases[i,j].croix) and (tab_cases[i,j+1].croix) and (tab_cases[i,j+2].croix) then
										victoire_croix:=true
									else
										if (tab_cases[i,j].croix) and (tab_cases[i+1,j+1].croix) and (tab_cases[i+2,j+2].croix) then
											victoire_croix:=true;
							end;
						if ((i = 2) and (j = 1))then
							if (tab_cases[i,j].croix) and (tab_cases[i,j+1].croix) and (tab_cases[i,j+2].croix) then
								victoire_croix := true;

						if ((i = 3) and (j = 1))then
							if (tab_cases[i,j].croix) and (tab_cases[i,j+1].croix) and (tab_cases[i,j+2].croix) then
								victoire_croix := true;

						if ((j = 2) and (i = 1)) then
							if (tab_cases[i,j].croix) and (tab_cases[i+1,j].croix) and (tab_cases[i+2,j].croix) then
								victoire_croix := true;

						if ((j = 3) and (i = 1)) then
							if (tab_cases[i,j].croix) and (tab_cases[i+1,j].croix) and (tab_cases[i+2,j].croix) then
								victoire_croix := true;
					End;
			End;

		verif_victoire_croix:=victoire_croix;
	End;

function verif_victoire_rond(tab_cases : tableau_cases) : boolean;

	Var

		i,j :integer;
		victoire_rond : boolean;

	Begin
		victoire_rond := false;
		for j := 1 to 3 do
			Begin
				for i := 1 to 3 do
					Begin
						if ((i = 1) and (j = 1)) then
							begin
								if (tab_cases[i,j].rond) and (tab_cases[i+1,j].rond) and (tab_cases[i+2,j].rond) then
									victoire_rond:=true
								else
									if (tab_cases[i,j].rond) and (tab_cases[i,j+1].rond) and (tab_cases[i,j+2].rond) then
										victoire_rond:=true
									else
										if (tab_cases[i,j].rond) and (tab_cases[i+1,j+1].rond) and (tab_cases[i+2,j+2].rond) then
											victoire_rond:=true;
							end;
						if ((i = 2) and (j = 1))then
							if (tab_cases[i,j].rond) and (tab_cases[i,j+1].rond) and (tab_cases[i,j+2].rond) then
								victoire_rond := true;

						if ((i = 3) and (j = 1))then
							if (tab_cases[i,j].rond) and (tab_cases[i,j+1].rond) and (tab_cases[i,j+2].rond) then
								victoire_rond := true;

						if ((j = 2) and (i = 1)) then
							if (tab_cases[i,j].rond) and (tab_cases[i+1,j].rond) and (tab_cases[i+2,j].rond) then
								victoire_rond := true;

						if ((j = 3) and (i = 1)) then
							if (tab_cases[i,j].rond) and (tab_cases[i+1,j].rond) and (tab_cases[i+2,j].rond) then
								victoire_rond := true;
					End;
			End;
		verif_victoire_rond:=victoire_rond;
	End;

procedure tour_de_jeu (var tab_cases : tableau_cases ;var  tab_cases_utiliser : tableau_cases_utiliser ;var joueur_croix,joueur_rond : joueur);

	Var

		case_select : integer;

	Begin

		Repeat
			writeln('entrer le chiffre de la case ou dans la quel vous voulez mettre signe');
			readln(case_select);
		Until ( (case_select <10) and (case_select >0) and (verif_case_vide(case_select ,tab_cases_utiliser) ) );
		If (joueur_croix.actif) then
			Begin
				case case_select of
					1:tab_cases[1,1].croix:=true;
					2:tab_cases[1,2].croix:=true;
					3:tab_cases[1,3].croix:=true;
					4:tab_cases[2,1].croix:=true;
					5:tab_cases[2,2].croix:=true;
					6:tab_cases[2,3].croix:=true;
					7:tab_cases[3,1].croix:=true;
					8:tab_cases[3,2].croix:=true;
					9:tab_cases[3,3].croix:=true;
				End;
			End;
		If (joueur_rond.actif) then
			Begin
				case case_select of
					1:tab_cases[1,1].rond:=true;
					2:tab_cases[1,2].rond:=true;
					3:tab_cases[1,3].rond:=true;
					4:tab_cases[2,1].rond:=true;
					5:tab_cases[2,2].rond:=true;
					6:tab_cases[2,3].rond:=true;
					7:tab_cases[3,1].rond:=true;
					8:tab_cases[3,2].rond:=true;
					9:tab_cases[3,3].rond:=true;
				End;
			End;
	End;

procedure initalisation (var joueur_croix,joueur_rond : joueur ;var  tab_cases_utiliser : tableau_cases_utiliser ;var  tab_cases : tableau_cases);

	Var

		i,j : integer;

	Begin

		For i:=1 to 9 do
			tab_cases_utiliser[i]:=false;
		joueur_croix.actif:=true;
		joueur_rond.actif:=false;

		For i:=1 to 3 do
			For j:=1 to 3 do
				Begin
					tab_cases[i,j].croix:=false;
					tab_cases[i,j].rond:=false;
				End;
	End;



procedure changement_joueur(var joueur_croix,joueur_rond : joueur);

	Begin

		If joueur_croix.actif Then
			Begin
				joueur_croix.actif:=false;
				joueur_rond.actif:=true;
			End
		else
			Begin
				joueur_croix.actif:=true;
				joueur_rond.actif:=false;
			End;
	End;

Var
	gd, gm: smallint;
	tab_cases : tableau_cases;
	tab_cases_utiliser : tableau_cases_utiliser;
	joueur_croix,joueur_rond : joueur;
	compteur,nb_partie : integer;

Begin
	gd := vga;
	gm := vgahi;
	initgraph(gd, gm, '');
	IF graphresult = grok THEN
		writeln('combien de partie pour finir le jeu ?');
		readln(nb_partie);
		Repeat
			clrscr;
			writeln('entrer le nom du joueur croix');
			readln(joueur_croix.nom);
			clrscr;
			writeln('entrer le nom du joueur rond');
			readln(joueur_rond.nom);
			affichage(tab_cases);
			initalisation(joueur_croix,joueur_rond , tab_cases_utiliser , tab_cases);
			Repeat
				clrscr;
				compteur:=compteur+1;
				tour_de_jeu (tab_cases , tab_cases_utiliser , joueur_croix,joueur_rond);
				affichage(tab_cases);
				If (compteur > 4) then
					Begin
						If (verif_victoire_croix(tab_cases)) Then
							Begin
								writeln('le joueur :',joueur_croix.nom,' remporte la partie');
								joueur_croix.nb_partie_win:=joueur_croix.nb_partie_win+1;
							End;
						If (verif_victoire_rond(tab_cases)) Then
							Begin
								writeln('le joueur :',joueur_rond.nom,' remporte la partie');
								joueur_rond.nb_partie_win:=joueur_rond.nb_partie_win+1;
							End;
						If (verif_victoire_croix(tab_cases) = false) and (verif_victoire_rond(tab_cases) = false) and (compteur=9) Then
							Begin
								writeln('egaliter parfaite ! ');
							End;
					End;
				changement_joueur(joueur_croix,joueur_rond);
			Until (verif_victoire_croix(tab_cases)) or (verif_victoire_rond(tab_cases)) or (compteur=9);
	        readln;
	    Until (joueur_rond.nb_partie_win = nb_partie) or (joueur_rond.nb_partie_win = nb_partie);
	    if (joueur_rond.nb_partie_win = nb_partie) then
	    	writeln('le joueur :',joueur_rond.nom,' remporte la Game')
	    else
	    	writeln('le joueur :',joueur_croix.nom,' remporte la Game');
End.			

