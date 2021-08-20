package kr.ac.kyonggi.swaig.handler.dto.monitor;

public class MemoryDTO {
    public String heapMemory, nonHeapMemory, total, free;

    public String getHeapMemory() {
        return heapMemory;
    }

    public void setHeapMemory(String heapMemory) {
        this.heapMemory = heapMemory;
    }

    public String getNonHeapMemory() {
        return nonHeapMemory;
    }

    public void setNonHeapMemory(String nonHeapMemory) {
        this.nonHeapMemory = nonHeapMemory;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getFree() {
        return free;
    }

    public void setFree(String free) {
        this.free = free;
    }
}
