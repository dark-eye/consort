
function constructQuery(query) {
    //build functions
    return JSON.stringify(query).replace(/"([\w\d_]*)":/g,"\1");
}
