#include <iostream>
#include <unordered_map>
#include <stack>

using namespace std;

// LL(1) Grammar production rules
unordered_map<char, string> productions = {
    {'E', "TG"},
    {'G', "+TG|epsilon"},
    {'T', "FS"},
    {'S', "*FS|epsilon"},
    {'F', "(E)|i"}
};

// FIRST sets for non-terminals
unordered_map<char, string> firstSets = {
    {'E', "(, i"},
    {'G', "+, epsilon"},
    {'T', "(, i"},
    {'S', "*, epsilon"},
    {'F', "(, i"}
};

// FOLLOW sets for non-terminals
unordered_map<char, string> followSets = {
    {'E', "$, )"},
    {'G', "$, )"},
    {'T', "+, $, )"},
    {'S', "+, $, )"},
    {'F', "+, *, $, )"}
};

// LL(1) Parsing table
unordered_map<char, unordered_map<char, string>> ll1Table = {
    {'E', {{'(', "TG"}, {'i', "TG"}}},
    {'G', {{'+', "+TG"}, {')', "epsilon"}, {'$', "epsilon"}}},
    {'T', {{'(', "FS"}, {'i', "FS"}}},
    {'S', {{'*', "*FS"}, {'+', "epsilon"}, {')', "epsilon"}, {'$', "epsilon"}}},
    {'F', {{'(', "(E)"}, {'i', "i"}}}
};

// Function to check if the given symbol is a non-terminal
bool isNonTerminal(char symbol) {
    return symbol >= 'A' && symbol <= 'Z';
}

// Function to parse the input string
bool parseInput(const string& input) {
    stack<char> parseStack;
    parseStack.push('$');
    parseStack.push('E');

    size_t index = 0;
    char currentSymbol = parseStack.top();
    while (currentSymbol != '$') {
        if (currentSymbol == input[index]) {
            parseStack.pop();
            index++;
        } else if (isNonTerminal(currentSymbol)) {
            char inputSymbol = input[index];
            string production = ll1Table[currentSymbol][inputSymbol];

            if (production == "") {
                cout << "Error: No production found for (" << currentSymbol << ", " << inputSymbol << ")" << endl;
                return false;
            }

            parseStack.pop();
            for (int i = production.length() - 1; i >= 0; i--) {
                if (production[i] != 'e') // 'e' represents epsilon
                    parseStack.push(production[i]);
            }
        } else {
            cout << "Error: Mismatch between input symbol and stack symbol." << endl;
            return false;
        }

        currentSymbol = parseStack.top();
    }

    return true;
}

int main() {
    string input1 = "i+i*i";
    string input2 = "i*i+i)";

    cout << "Parsing input1: " << input1 << endl;
    if (parseInput(input1)) {
        cout << "Input1 parsed successfully." << endl;
    } else {
        cout << "Input1 parsing failed." << endl;
    }

    cout << endl;

    cout << "Parsing input2: " << input2 << endl;
    if (parseInput(input2)) {
        cout << "Input2 parsed successfully." << endl;
    } else {
        cout << "Input2 parsing failed." << endl;
    }

    return 0;
}

