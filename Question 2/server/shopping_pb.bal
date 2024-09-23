import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F120873686F7070696E671A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A06737461747573180620012809520673746174757322570A0E50726F647563744D65737361676512180A076D65737361676518012001280952076D657373616765122B0A0770726F6475637418022001280B32112E73686F7070696E672E50726F64756374520770726F6475637422310A044361727412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522400A0B436172744D65737361676512170A07757365725F6964180120012809520675736572496412180A076D65737361676518022001280952076D657373616765222C0A11706C6163654F726465725265717565737412170A07757365725F6964180120012809520675736572496422410A0C4F726465724D65737361676512170A07757365725F6964180120012809520675736572496412180A076D65737361676518022001280952076D657373616765223E0A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C65223B0A13557365724372656174696F6E4D65737361676512240A05757365727318012003280B320E2E73686F7070696E672E5573657252057573657273222A0A0C55736572526573706F6E7365121A0A08726573706F6E73651801200128095208726573706F6E7365223D0A0C4C697374526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F64756374733299050A0E6F6E6C696E6553686F7070696E6712390A0A61646450726F6475637412112E73686F7070696E672E50726F647563741A182E73686F7070696E672E50726F647563744D657373616765123C0A0D75706461746550726F6475637412112E73686F7070696E672E50726F647563741A182E73686F7070696E672E50726F647563744D65737361676512470A0D72656D6F766550726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A182E73686F7070696E672E50726F647563744D65737361676512470A156C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A162E73686F7070696E672E4C697374526573706F6E736512470A0D73656172636850726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A182E73686F7070696E672E50726F647563744D65737361676512320A09616464546F43617274120E2E73686F7070696E672E436172741A152E73686F7070696E672E436172744D65737361676512410A0A706C6163654F72646572121B2E73686F7070696E672E706C6163654F72646572526571756573741A162E73686F7070696E672E4F726465724D657373616765123E0A0B6372656174655573657273120E2E73686F7070696E672E557365721A1D2E73686F7070696E672E557365724372656174696F6E4D657373616765280112370A0767657455736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0E2E73686F7070696E672E5573657212430A0B64656C6574655573657273121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E73686F7070696E672E55736572526573706F6E7365620670726F746F33";

public isolated client class onlineShoppingClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function addProduct(Product|ContextProduct req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function addProductContext(Product|ContextProduct req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }

    isolated remote function updateProduct(Product|ContextProduct req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function updateProductContext(Product|ContextProduct req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }

    isolated remote function removeProduct(string|wrappers:ContextString req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function removeProductContext(string|wrappers:ContextString req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.onlineShopping/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }