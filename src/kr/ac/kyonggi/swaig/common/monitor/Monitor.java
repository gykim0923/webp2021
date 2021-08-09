package kr.ac.kyonggi.swaig.common.monitor;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.management.OperatingSystemMXBean;
import kr.ac.kyonggi.swaig.handler.dao.settings.AdminDAO;

public class Monitor {
    public static Monitor it;

    public static Monitor getInstance() { //인스턴스 생성
        if (it == null)
            it = new Monitor();
        return it;
    }

    static double kb = 1024.0;
    static double mb = 1024.0 * 1024.0;
    static double gb = 1024.0 * 1024.0 * 1024;

    public List<Map<String, String>> getSpaceInfo() {
        List<Map<String, String>> listOfMaps = new ArrayList<Map<String, String>>();
        String disk = "";
        double total = 0;
        double used = 0;
        double free = 0;
        File[] drives = File.listRoots();
        for(File drive : drives) {
            Map<String,String> result = new HashMap<String,String>();
            disk = drive.getAbsolutePath();
            total = drive.getTotalSpace() / Math.pow(1024, 3);
            free = drive.getUsableSpace() / Math.pow(1024, 3);
            used = total - free;
            result.put("disk", disk);
            result.put("total", String.valueOf(total));
            result.put("used", String.valueOf(used));
            result.put("free", String.valueOf(free));
            listOfMaps.add(result);
        }
        return listOfMaps;
    }

    public void showOSBean( ){

        //OS 설정 확인하는 코드
        OperatingSystemMXBean osbean = ( OperatingSystemMXBean ) ManagementFactory.getOperatingSystemMXBean( );
        System.out.println( "OS Name: " + osbean.getName( ) );
        System.out.println( "OS Arch: " + osbean.getArch( ) );
        System.out.println( "Available Processors: " + osbean.getAvailableProcessors( ) );
    }

    public void showMemory(){

        //자바 힙메모리 크기 확인하는 코드
        MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean( );
        MemoryUsage heap = membean.getHeapMemoryUsage();
        System.out.println( "Heap Memory: " + heap.getUsed()/mb+"MB");
        MemoryUsage nonheap = membean.getNonHeapMemoryUsage();
        System.out.println( "NonHeap Memory: " + nonheap.getUsed()/mb+"MB");
    }

    public void showCPU() {

        //현재 cpu 사용량 확인하는 코드 이것만은 실시간으로 출력되게 만들었습니다

        final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean)ManagementFactory.getOperatingSystemMXBean();
        double load;
        while(true){
            load = osBean.getSystemCpuLoad();
            System.out.println("CPU Usage : "+load*100.0+"%");
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public void systemMemory () {
        //시스템 메모리
        Runtime runtime = Runtime.getRuntime();
        int total = (int)(runtime.totalMemory()/mb);
        int free = (int)(runtime.freeMemory()/mb);
        int used = total - free;

        System.out.println("전체 메모리" + total+"MB");
        System.out.println("사용중인 메모리" + free +"MB");
        System.out.println("사용가능한 메모리"+used +"MB");

    }
}
