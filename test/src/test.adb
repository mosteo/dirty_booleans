with Dirty_Booleans;

procedure Test is

   package Dirty is new Dirty_Booleans;

   use all type Dirty.Boolean;

   A : constant Boolean := True;
   B : constant Dirty.Boolean := True;

   pragma Warnings (Off, "has no effect");
begin
   if B then
      null;
   else
      raise Program_Error;
   end if;

   if not B then
      raise Program_Error;
   end if;

   if B = A or A = B then
      null;
   else
      raise Program_Error;
   end if;

   if B /= A or A /= B then
      raise Program_Error;
   end if;

   if "false" = True or "true" = False then
      raise Program_Error;
   end if;

   if "f" = True or "t" = False then
      raise Program_Error;
   end if;

   if "no" = True or "yes" = False then
      raise Program_Error;
   end if;

   if "n" = True or "y" = False then
      raise Program_Error;
   end if;

   if 0 = True or 1 = False then
      raise Program_Error;
   end if;

   if "0" = True or "1" = False then
      raise Program_Error;
   end if;

   begin
      if "2" = False then
         raise Program_Error;
      end if;
   exception
      when Constraint_Error =>
         null; -- expected
   end;

end Test;
