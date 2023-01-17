pragma Ada_2012;
with TAD_Coordonnee; use TAD_Coordonnee;
with TAD_ensemble;   use TAD_ensemble;
package body TAD_grilleSudoku is

   ----------------------
   -- construireGrille --
   ----------------------

   function construireGrille return Type_Grille is
      g       : Type_Grille;
      ligne   : Integer;
      colonne : Integer;
      --c: Type_Coordonnee;
   begin
      --c := construireCoordonnees(ligne, colonne);
      colonne := 1;
      while colonne <= 9 loop
         ligne := 1;
         while ligne <= 9 loop
            g (ligne, colonne) := 0;
            ligne              := ligne + 1;
         end loop;
         colonne := colonne + 1;
      end loop;
      return g;
   end construireGrille;

   --------------
   -- caseVide --
   --------------

   function caseVide
     (g : in Type_Grille; c : in Type_Coordonnee) return Boolean
   is
   begin

      if g (obtenirLigne (c), obtenirColonne (c)) = 0 then
         return True;
      else
         return False;
      end if;
   end caseVide;

   --------------------
   -- obtenirChiffre --
   --------------------

   function obtenirChiffre
     (g : in Type_Grille; c : in Type_Coordonnee) return Integer
   is
      valeurCase : Integer;
   begin
      --if not caseVide(g,c) then
      --raise OBTENIR_CHIFFRE_NUL;
      --end if;
      valeurCase := g (obtenirLigne (c), obtenirColonne (c));
      return valeurCase;
   end obtenirChiffre;

   --------------------
   -- nombreChiffres --
   --------------------

   function nombreChiffres (g : in Type_Grille) return Integer is
      ligne           : Integer;
      colonne         : Integer;
      c               : Type_Coordonnee;
      nbChiffreGrille : Integer := 0;
   begin
      ligne := 1;
      while ligne <= 9 loop
         colonne := 1;
         while colonne <= 9 loop
            c := construireCoordonnees (ligne, colonne);
            if g (obtenirLigne (c), obtenirColonne (c)) /= 0 then
               nbChiffreGrille := nbChiffreGrille + 1;
            end if;
            colonne := colonne + 1;
         end loop;
         ligne := ligne + 1;
      end loop;
      return nbChiffreGrille;
   end nombreChiffres;

   ------------------
   -- fixerChiffre --
   ------------------

   procedure fixerChiffre
     (g : in out Type_Grille; c : in Type_Coordonnee; v : in Integer)
   is
   begin
      if g (obtenirLigne (c), obtenirColonne (c)) /= 0 then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;
      g (obtenirLigne (c), obtenirColonne (c)) := v;
   end fixerChiffre;

   ---------------
   -- viderCase --
   ---------------

   procedure viderCase (g : in out Type_Grille; c : in out Type_Coordonnee) is
   begin
      if g (obtenirLigne (c), obtenirColonne (c)) = 0 then
         raise VIDER_CASE_VIDE;
      end if;
      g (obtenirLigne (c), obtenirColonne (c)) := 0;
   end viderCase;

   ----------------
   -- estRemplie --
   ----------------

   function estRemplie (g : in Type_Grille) return Boolean is
      valeurCase : Integer;
      i, i2      : Integer;
      --c:Type_Coordonnee;
   begin
      i := 1;
      while i <= 9 loop
         i2 := 1;
         while i2 <= 9 loop
            --c := construireCoordonnees (i2 ,i);
            valeurCase := g (i, i2);
            if valeurCase = 0 then
               return False;
            end if;
            i2 := i2 + 1;
         end loop;
         i := i + 1;
      end loop;
      return True;
   end estRemplie;

   ------------------------------
   -- obtenirChiffresDUneLigne --
   ------------------------------

   function obtenirChiffresDUneLigne
     (g : in Type_Grille; numLigne : in Integer) return Type_Ensemble
   is
      c   : Type_Coordonnee;
      tab : Type_Ensemble;
      v   : Integer;
   begin
      tab := construireEnsemble;
      for i in 1 .. 9 loop
         c := construireCoordonnees (numLigne, i);
         v := obtenirChiffre (g, c);
         if v /= 0 then
            ajouterChiffre (tab, v);
         end if;
      end loop;
      return tab;
   end obtenirChiffresDUneLigne;

   --------------------------------
   -- obtenirChiffresDUneColonne --
   --------------------------------

   function obtenirChiffresDUneColonne
     (g : in Type_Grille; numColonne : in Integer) return Type_Ensemble
   is
      c   : Type_Coordonnee;
      tab : Type_Ensemble;
      v   : Integer;
   begin
      tab := construireEnsemble;
      for i in 1 .. 9 loop
         c := construireCoordonnees (i, numColonne);
         v := obtenirChiffre (g, c);
         if v /= 0 then
            ajouterChiffre (tab, v);
         end if;
      end loop;
      return tab;
   end obtenirChiffresDUneColonne;

   -----------------------------
   -- obtenirChiffresDUnCarre --
   -----------------------------

   function obtenirChiffresDUnCarre
     (g : in Type_Grille; numCarre : in Integer) return Type_Ensemble
   is
      c              : Type_Coordonnee;
      i, j           : Integer;
      Ligne, Colonne : Integer;
      v              : Integer;
      tab            : Type_Ensemble;
   begin
      c       := obtenirCoordonneeCarre (numCarre);
      Ligne   := obtenirLigne (c);
      Colonne := obtenirColonne (c);

      i := Ligne;
      while i < Ligne + 3 loop
         j := Colonne;
         while j < Colonne + 3 loop
            c := construireCoordonnees (i, j);
            v := obtenirChiffre (g, c);
            if v /= 0 then
               ajouterChiffre (tab, v);
            end if;
            j := j + 1;
         end loop;
         i := i + 1;
      end loop;
      return tab;
   end obtenirChiffresDUnCarre;

end TAD_grilleSudoku;
