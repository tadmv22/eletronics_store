package com.electronicsstore.dto;

import java.util.List;

public class PagedList<T> {

    private int page;
    private int pageSize;
    private int totalCount;
    private List<T> items;

    public PagedList(int page, int pageSize, int totalCount, List<T> items) {
        this.page = page;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.items = items;
    }

    public int getPage() {
        return page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public List<T> getItems() {
        return items;
    }
    
    public int totalPages() {
        return Math.round(this.totalCount / this.pageSize);
    }

    public boolean HasNextPage() {
        return this.page * this.pageSize < this.totalCount;
    }

    public int nextPage() {
        if (this.HasNextPage()) {
            return this.page + 1;
        }
        return Math.round(this.totalCount / this.pageSize);
    }

    public boolean HasPreviousPage() {
        return this.page > 1;
    }

    public int previousPage() {
        if (this.HasPreviousPage()) {
            return this.page - 1;
        }
        return 1;
    }
}
