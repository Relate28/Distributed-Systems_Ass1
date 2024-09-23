import ballerina/io;

onlineShoppingClient ep = check new ("http://localhost:9090");

function insertProductDetails() returns Product|error{
    string name = io:readln("Enter Product Name: ");
    string description = io:readln("Enter Product Description: ");
    string price = io:readln("Enter product price: ");
    string stock_quantity = io:readln("Enter product stock quantity: ");
    string sku = io:readln("Enter product sku: ");
    string status = io:readln("Enter product status: ");

    float|error priceValue = check float:fromString(price);
    int|error stock_quantityValue = check int:fromString(stock_quantity);

    Product product = {name: name, description: description, price: check priceValue, stock_quantity: check stock_quantityValue, sku: sku, status: status.toUpperAscii()};
    return product;
}
function addProduct() returns ProductMessage|error? {
    Product ProductRequest = check insertProductDetails();
    ProductMessage addProductResponse = check ep->addProduct(ProductRequest);
    return io:println(addProductResponse);

}

function updateProduct() returns ProductMessage|error? {
    Product ProductRequest = check insertProductDetails();
    ProductMessage updateProductResponse = check ep->updateProduct(ProductRequest);
    return io:println(updateProductResponse);
}

function removeProduct() returns ProductMessage|error? {
    string sku = io:readln("Enter product sku: ");
    ProductMessage removeProductResponse = check ep->removeProduct(sku);
    return io:println(removeProductResponse);
}

function searchProduct() returns ProductMessage|error? {
    string sku = io:readln("Enter product sku: ");
    ProductMessage searchProductResponse = check ep->searchProduct(sku);
    return io:println(searchProductResponse);
}

function addToCart() returns CartMessage|error? {
    string user_id = io:readln("Enter user id: ");
    string sku = io:readln("Enter Product sku: ");

    Cart CartRequest = {user_id: user_id, sku: sku};
    CartMessage addToCartResponse = check ep->addToCart(CartRequest);
    return io:print(addToCartResponse);
}

function placeOrder() returns OrderMessage|error? {
    string user_id = io:readln("Enter user id: ");
    placeOrderRequest placeOrderRequest = {user_id: user_id};
    OrderMessage placeOrderResponse = check ep->placeOrder(placeOrderRequest);
    return io:println(placeOrderResponse);
}

function getUser() returns User|error?{
    string getUserRequest = io:readln();
    User getUserResponse = check ep->getUser(getUserRequest);
    return getUserResponse;
}

function deleteUsers() returns UserResponse|error?{
    string deleteUsersRequest = io:readln();
    UserResponse deleteUsersResponse = check ep->deleteUsers(deleteUsersRequest);
    return deleteUsersResponse;
}

function createUsers() returns UserCreationMessage|error?{
    string id = io:readln("Enter user id: ");
    string name = io:readln("Enter user name: ");
    string user_role = io:readln("Enter Role: 1. Admin 2. User");
    if user_role == "1"{
        user_role = "Admin";
    }
    else if user_role == "2"{
        user_role = "User";
    }
    User user = {id: id, name: name, role: user_role};
    CreateUsersStreamingClient createUsersResponse = check ep->createUsers();
    check createUsersResponse->sendUser(user);
    check createUsersResponse->complete();
    UserCreationMessage? userCreationMessage = check createUsersResponse->receiveUserCreationMessage();
    return userCreationMessage;
}

function listAvailable() returns error?{
    ListResponse listAvailableProductsResponse = check ep->listAvailableProducts();
    io:println(listAvailableProductsResponse);
    
}

public function main() returns error? {
    
    io:println("--- Login ---");
    string id = io:readln("Enter user id: ");
    io:println("Are you an Admin or User");
    string role = io:readln("Enter Role: 1. Admin 2. User: ");
    
    User getUserResponse = check ep->getUser(id);

    string user_role = getUserResponse.role;

    if (role == "1" && user_role == "Admin"){ {
        boolean run = true;
        while true{
        io:println("Login Successful");
        io:println("Enter 1 to add product");
        io:println("Enter 2 to update product");
        io:println("Enter 3 to remove product");
        io:println("Enter 4 to search product");
        io:println("Enter 5 to delete user");
        io:println("Enter 6 to create users");
        io:println("Enter 7 to list Available products");
        io:println("Enter 8 to exit");
        

        while run {
            string option = io:readln("Enter Choice:");
            if (option == "1") {
                ProductMessage? addProductResponse = check addProduct();
                io:println(addProductResponse);
            }
            else if (option == "2") {
                ProductMessage? updateProductResponse = check updateProduct();
                io:println(updateProductResponse);
            }
            else if (option == "3") {
                ProductMessage? removeProductResponse = check removeProduct();
                io:println(removeProductResponse);
            
                check listAvailable();
                

            }

            else if (option == "4") {
                ProductMessage? searchProductResponse = check searchProduct();
                io:println(searchProductResponse);
            }
            
            else if (option == "5"){
                UserResponse? deleteUsersResponse = check deleteUsers();
                io:println(deleteUsersResponse);
            }

            else if (option == "6"){
                UserCreationMessage? createUsersResponse = check createUsers();
                io:println(createUsersResponse);
            }

            else if (option == "7"){
                 check listAvailable();

            }
            else if (option == "8"){
                break;
            }
        }
            io:println("Thank you for using the system");
            break;
        }
        }
    }

        else if (role == "2" && user_role == "User") {
            boolean run = true;
            io:println("Login Successful");
            while run{
            io:println("1.List Available Product");
            io:println("2. Add product to cart");
            io:println("3. Place order");
            io:println("4. Exit");
            
            while run {
            string option = io:readln("Enter Number: ");
            if option == "1"{
                check listAvailable();
               
            }
            if option == "2"{
                CartMessage? addToCartResponse = check addToCart();
                io:println(addToCartResponse);
            }
            if option == "3"{
                OrderMessage? placeOrderResponse = check placeOrder();
                io:println(placeOrderResponse);
            }
            if option == "4"{
                run = false;
            }
            io:println("Thank you for using the system");
        }
            }
        }
    
}

