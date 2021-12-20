function greet(msg,occasion){
    switch(occasion){
        case "New Year":
            console.log("On the "+occasion+" occasion, I say: "+msg);
            break;
        case "Birthday":
            console.log("On the "+occasion+" occasion, I say: "+msg);
            break;
        case "Anniversary": 
            console.log("On the "+occasion+" occasion, I say: "+msg);
            break;
        case "christmas":
            console.log("On the "+occasion+" occasion, I say: "+msg);
            break;

    }
}
greet("Happy New Year","New Year");
greet("Happy Birthday","Birthday");
greet("Happy Anniversary","Anniversary");
greet("Happy Christmas","christmas");