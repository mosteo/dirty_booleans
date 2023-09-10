with Ada.Characters.Conversions;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Wide_Wide_Characters.Handling;

package body Dirty_Booleans is

   -----------
   -- Value --
   -----------

   function Value (S : String) return Dirty_Boolean
   is (Value (Ada.Characters.Conversions.To_Wide_Wide_String (S)));

   -----------
   -- Value --
   -----------

   function Value (S : Wide_Wide_String) return Dirty_Boolean
   is
      use Ada.Strings.Wide_Wide_Fixed;
      use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
      use Ada.Wide_Wide_Characters.Handling;
      N : constant Wide_Wide_String :=
            Trim (To_Lower (S), Ada.Strings.Both);
   begin
      if Enable_No_Yes then
         if N = "no" then
            return False;
         elsif N = "yes" then
            return True;
         end if;
      end if;

      if Enable_N_Y then
         if N = "n" then
            return False;
         elsif N = "y" then
            return True;
         end if;
      end if;

      if Enable_False_True then
         if N = "false" then
            return False;
         elsif N = "true" then
            return True;
         end if;
      end if;

      if Enable_F_T then
         if N = "f" then
            return False;
         elsif N = "t" then
            return True;
         end if;
      end if;

      if Enable_Empty and then N = "" then
         return False;
      end if;

      if Enable_Non_Empty and then N /= "" then
         return True;
      end if;

      if Enable_0_1_Str then
         if N = "0" then
            return False;
         elsif N = "1" then
            return True;
         end if;
      end if;

      begin
         if Enable_Non_Zero_Str then
            if Integer'Wide_Wide_Value (N) /= 0 then
               return True;
            else
               return False;
            end if;
         end if;
      exception
         when others =>
            null; -- Not an int
      end;

      raise Constraint_Error
        with "String doesn't match any recognized value: "
        & Encode (N);
   end Value;

   -----------
   -- Value --
   -----------

   function Value (I : Integer) return Dirty_Boolean
   is (if Enable_Non_Zero
       then Dirty_Boolean (I /= 0)
       elsif Enable_0_1
       then
         (case I is
             when 0 => False,
             when 1 => True,
             when others =>
                raise Constraint_Error with
                  "Value out of range 0/1:" & I'Image)
       else raise Constraint_Error with "Comparisons with numbers disabled");

end Dirty_Booleans;
