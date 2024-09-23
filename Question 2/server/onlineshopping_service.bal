import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

table<Product> key (sku) products_table = table[];
table<Cart>  key(user_id) carts_table = table[];

table<User> key (id) users_table = table[{name: "Admin", role: "Admin", id: "Admin"}];   

@grpc:Descriptor {value: SHOPPING_DESC}

service "onlineShopping" on ep {

    remote function addProduct(Product value) returns ProductMessage|error {
        products_table.add(value);
        return {message: "Product Added successfully", product: value };
    }

    remote function updateProduct(Product value) returns ProductMessage|error {
        products_table.put(value);
        return{message: "Product Updated successfully"};
    }

    remote function removeProduct(string value) returns ProductMessage|error {
        if !products_table.hasKey(value) {
            return error("Product not found");
        }
        else{
            Product removedProduct = products_table.remove(value);
            return{message: "Product Removed successfully", product: removedProduct};
        }
    }

    remote function listAvailableProducts() returns ListResponse|error {
        table<Product> products = products_table.filter(pro => pro.status == "AVAILABLE");
        Product[] list = products.toArray();
        return {products: list};
    }

    remote function searchProduct(string value) returns ProductMessage|error {
        if products_table.hasKey(value) {
            return{message: "Product Found successfully", product: products_table.get(value)};
        }
        else {
            return error("Product not found");
        }
        
    }

    remote function addToCart(Cart value) returns CartMessage|error {
        if products_table.hasKey(value.sku) {
            Product product = products_table.get(value.sku);
            int int_stock = product.stock_quantity - 1;
            product.stock_quantity = int_stock;
            products_table.put(product);
            carts_table.add(value);
            return{message: "Product Added to cart successfully"};  
        }

        else {
            return error("Product not found");
        } 
    }

    
