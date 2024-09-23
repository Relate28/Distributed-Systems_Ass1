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