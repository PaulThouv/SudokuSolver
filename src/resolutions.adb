pragma Ada_2012;

with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;

package body resolutions is

   -----------------------
   -- estChiffreValable --
   -----------------------

   function estChiffreValable
     (g : in Type_Grille; v : Integer; c : Type_Coordonnee) return Boolean
   is
      e       : Type_Ensemble;
      ligne   : Integer;
      colonne : Integer;
   begin
      if caseVide (g, c) = True then
         raise CASE_NON_VIDE;
      end if;

      ligne   := obtenirLigne (c);
      colonne := obtenirColonne (c);
      e       := obtenirChiffresDUneLigne (g, ligne);
      if appartientChiffre (e, v) = True then
         return False;
      end if;

      e := obtenirChiffresDUneColonne (g, colonne);
      if appartientChiffre (e, v) then
         return False;
      end if;

      e := obtenirChiffresDUnCarre (g, obtenirCarre (c));
      if appartientChiffre (e, v) then
         return False;
      end if;

      return True;

   end estChiffreValable;

   -------------------------------
   -- obtenirSolutionsPossibles --
   -------------------------------

   function obtenirSolutionsPossibles
     (g : in Type_Grille; c : in Type_Coordonnee) return Type_Ensemble
   is
      i : Integer;
      e : Type_Ensemble;
   begin
      if caseVide (g, c) = True then
         raise CASE_NON_VIDE;
      end if;
      i := 1;
      while i <= 9 loop
         if estChiffreValable (g, i, c) then
            ajouterChiffre (e, i);
         end if;
         i := i + 1;
      end loop;
      return e;
   end obtenirSolutionsPossibles;

   ------------------------------------------
   -- rechercherSolutionUniqueDansEnsemble --
   ------------------------------------------

   function rechercherSolutionUniqueDansEnsemble
     (resultats : in Type_Ensemble) return Integer
   is
      i : Integer;
      c : Integer;
   begin
      i := 1;
      c := 0;
      while i <= 9 loop
         if resultats (i) = True then
            c := c + 1;
         end if;
         if c >= 2 then
            raise PLUS_DE_UN_CHIFFRE;
         end if;
         i := 1;
      end loop;

      while i <= 9 loop
         if resultats (i) = True then
            return resultats (i);
         end if;
         i := i + 1;
      end loop;
   end rechercherSolutionUniqueDansEnsemble;

   --------------------
   -- resoudreSudoku --
   --------------------

   procedure resoudreSudoku (g : in out Type_Grille; trouve : out Boolean) is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "resoudreSudoku unimplemented");
      raise Program_Error with "Unimplemented procedure resoudreSudoku";
   end resoudreSudoku;

end resolutions;
