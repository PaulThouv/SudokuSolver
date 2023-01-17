pragma Ada_2012;
package body TAD_ensemble is

   ------------------------
   -- construireEnsemble --
   ------------------------

   function construireEnsemble return Type_Ensemble is
      e : Type_Ensemble;
      i : Integer;
   begin
      i := 1;
      while i <= 9 loop
         e (i) := False;
         i     := i + 1;
      end loop;

      return e;
   end construireEnsemble;

   ------------------
   -- ensembleVide --
   ------------------

   function ensembleVide (e : in Type_Ensemble) return Boolean is
      i : Integer;
   begin
      i := 1;
      while i <= 9 loop
         if e (i) = True then
            return False;
         else
            i := i + 1;
         end if;
      end loop;
      return True;

   end ensembleVide;

   -----------------------
   -- appartientChiffre --
   -----------------------

   function appartientChiffre
     (e : in Type_Ensemble; v : in Integer) return Boolean
   is
   begin
      if e (v) = True then
         return True;
      else
         return False;
      end if;

   end appartientChiffre;

   --------------------
   -- nombreChiffres --
   --------------------

   function nombreChiffres (e : in Type_Ensemble) return Integer is
      i        : Integer;
      compteur : Integer;
   begin
      i        := 1;
      compteur := 0;
      while i <= 9 loop
         if e (i) = True then
            compteur := compteur + 1;
         end if;
         i := i + 1;
      end loop;
      return compteur;
   end nombreChiffres;

   --------------------
   -- ajouterChiffre --
   --------------------

   procedure ajouterChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if appartientChiffre (e, v) then
         raise APPARTIENT_ENSEMBLE;
      end if;
      e (v) := True;

   end ajouterChiffre;

   --------------------
   -- retirerChiffre --
   --------------------

   procedure retirerChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if not appartientChiffre (e, v) then
         raise NON_APPARTIENT_ENSEMBLE;
      end if;
      e (v) := False;

   end retirerChiffre;

end TAD_ensemble;
