import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

table<Product> key (sku) products_table = table[];
table<Cart>  key(user_id) carts_table = table[];

table<User> key (id) users_table = table[{name: "Admin", role: "Admin", id: "Admin"}];   

@grpc:Descriptor {value: SHOPPING_DESC}

