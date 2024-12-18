package com.electronicsstore.dao;

import java.util.List;

public interface BaseDao<T> {

    public T create(T input);

    public T update(T input);

    public void delete(int id);

    public List<T> list(String search,int page, int size);

    public int getTotal();

    public T getById(int id);

}
