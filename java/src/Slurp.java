import java.io.IOException;
import java.io.PrintStream;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.simpleframework.http.Form;
import org.simpleframework.http.Request;
import org.simpleframework.http.Response;
import org.simpleframework.http.core.Container;
import org.simpleframework.transport.connect.Connection;
import org.simpleframework.transport.connect.SocketConnection;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Slurp implements Container {
	private Map<String, List<Object>> data = new HashMap<String, List<Object>>();
	private ObjectMapper mapper = new ObjectMapper(); 

	public void handle(Request request, Response response) {
		try {
    		if (request.getPath().getPath().equals("/receive"))
    			handleReceive(request, response);
    		else if (request.getPath().getPath().equals("/gather"))
    			handleGather(request, response);
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
	}
	
	public void handleReceive(Request request, Response response) throws IOException {
		Form form = request.getForm();
		List<Object> parts = new ArrayList<Object>();
		
		String name = form.get("n") + Math.random();
		
		parts.add(name);
		parts.add(form.get("c"));
		parts.add(form.get("t"));
		parts.add(form.getInteger("s"));
		parts.add(form.get("b"));
		parts.add(form.getInteger("u"));
		parts.add(form.getInteger("bn"));
		parts.add(form.get("i"));
		parts.add(form.getInteger("r"));

		data.put(name, parts);
		
		PrintStream body = response.getPrintStream();
		response.set("Content-Type", "text/plain");
		body.println("OK");
		body.close();
	}
	
	public void handleGather(Request request, Response response) throws IOException {
		PrintStream body = response.getPrintStream();
		response.set("Content-Type", "application/json");
		
		mapper.writeValue(body, data);
		data.clear();
		body.close();
	}

	public static void main(String[] list) throws Exception {
		Container container = new Slurp();
		Connection connection = new SocketConnection(container);
		SocketAddress address = new InetSocketAddress(8085);

		connection.connect(address);
	}
}