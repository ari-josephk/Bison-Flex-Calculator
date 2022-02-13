typedef struct var { char *name; float val; struct var *next; } var; //create struct to represent variable-store

var *var_table = NULL; //linked list table will store all our vars

//search var table for char name, return var struct or NULL
//Using a hash table would be more practical and faster here
//but for simplicity I implemented a linear O(n) search
var *get_var(char *name){
     for (var *p = var_table; p; p = p->next){
          if (strcmp (p->name, name) == 0)
               return p;
     }
     return NULL;
}

//put new var at the head of var table
//this also allows for reassignment of variables, although old-variable store is not overwritten
//a new one is simply created
void put_var(char *name, float val){
     var *put = (var *)malloc(sizeof (var)); //allocate space on heap for new var
     put->name = strdup(name);
     put->val = val;
     put->next = var_table;
     var_table = put;
}