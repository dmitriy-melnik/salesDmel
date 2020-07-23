public class StringArrayTest {
    public static List<String> generateStringArray(Integer parametr) {
        List<String> result = new List<String>();
        for (Integer i = 0; i < parametr; i++) {
            result.add('Test ' + i);
        }
        System.debug(result);
        return result;
    }
}