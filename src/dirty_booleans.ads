generic
   --  All are case-insensitive. Constraint error is raised when no valid value
   --  is interpreted.

   Enable_No_Yes     : Boolean := True;
   --  Strings "no"/"yes"

   Enable_N_Y        : Boolean := True;
   --  Strings "n"/"y"

   Enable_False_True : Boolean := True;
   --  Strings "false"/"true"

   Enable_F_T        : Boolean := True;
   --  Strings "f"/"t"

   Enable_Empty      : Boolean := True;
   --  "" is false

   Enable_Non_Empty  : Boolean := False;
   --  str /= "" is true. Incompatible will all other string comparisons

   Enable_0_1        : Boolean := True;
   --  Integer 0/1. If disabled, "=" will raise instead or returning False

   Enable_0_1_Str    : Boolean := True;
   --  Strings "0"/"1"

   Enable_Non_Zero   : Boolean := True;
   --  any number /= 0 is true. Implies Enable_0_1.

   Enable_Non_Zero_Str : Boolean := False;
   --  Any string that is a number and is non-zero is true

package Dirty_Booleans with Preelaborate is

   pragma Assert (if Enable_Non_Empty
                  then
                    not Enable_No_Yes and then
                    not Enable_N_Y and then
                    not Enable_False_True and then
                    not Enable_F_T and then
                    not Enable_0_1_Str);

   subtype Ada_Boolean is Standard.Boolean;

   type Dirty_Boolean is new Standard.Boolean;

   subtype Boolean is Dirty_Boolean;

   function "=" (L : Dirty_Boolean; R : Ada_Boolean) return Ada_Boolean;

   function "=" (L : Ada_Boolean; R : Dirty_Boolean) return Ada_Boolean;

   function "=" (L : Dirty_Boolean; R : String) return Ada_Boolean;

   function "=" (L : String; R : Dirty_Boolean) return Ada_Boolean;

   function "=" (L : Dirty_Boolean; R : Integer) return Ada_Boolean;

   function "=" (L : Integer; R : Dirty_Boolean) return Ada_Boolean;

   function Value (S : String) return Dirty_Boolean;

   function Value (S : Wide_Wide_String) return Dirty_Boolean;

   function Value (I : Integer) return Dirty_Boolean;

   function Value (B : Ada_Boolean) return Dirty_Boolean;

private

   function "=" (L : Dirty_Boolean; R : Ada_Boolean) return Ada_Boolean
   is (Ada_Boolean (L) = R);

   function "=" (L : Ada_Boolean; R : Dirty_Boolean) return Ada_Boolean
   is (Ada_Boolean (R) = L);

   function "=" (L : Dirty_Boolean; R : String) return Ada_Boolean
   is (L = Value (R));

   function "=" (L : String; R : Dirty_Boolean) return Ada_Boolean
   is (Value (L) = R);

   function "=" (L : Dirty_Boolean; R : Integer) return Ada_Boolean
   is (L = Value (R));

   function "=" (L : Integer; R : Dirty_Boolean) return Ada_Boolean
   is (Value (L) = R);

   function Value (B : Ada_Boolean) return Dirty_Boolean
   is (Dirty_Boolean (B));

end Dirty_Booleans;
