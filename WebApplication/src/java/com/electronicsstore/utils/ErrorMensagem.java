package com.electronicsstore.utils;

import java.util.HashMap;
import java.util.Map;


public class ErrorMensagem {
    private static final Map<Integer, String> errorMessages = new HashMap<>(){{
        put(1, "O email é obrigatório. Por favor, preencha este campo.");
        put(2, "O senha é obrigatório. Por favor, preencha este campo.");
        put(3, "Usuário ou senha incorretos. Por favor, verifique suas credenciais e tente novamente.");
        put(4, "Os dados de cadastros não podem ser vázios");
        put(5, "Este endereço de e-mail já está em uso!");
    }};
             
    public static String getMessageByCode(int code) {
        return errorMessages.getOrDefault(code, "Erro desconhecido");

    };    
}
