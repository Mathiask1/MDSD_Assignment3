package dk.sdu.mmmi.mdsd.generator

import dk.sdu.mmmi.mdsd.math.Div
import dk.sdu.mmmi.mdsd.math.LetBinding
import dk.sdu.mmmi.mdsd.math.MathExp
import dk.sdu.mmmi.mdsd.math.MathNumber
import dk.sdu.mmmi.mdsd.math.Minus
import dk.sdu.mmmi.mdsd.math.Mult
import dk.sdu.mmmi.mdsd.math.Plus
import dk.sdu.mmmi.mdsd.math.VarBinding
import dk.sdu.mmmi.mdsd.math.VariableUse
import dk.sdu.mmmi.mdsd.math.Parenthesis
import java.util.Map
import javax.swing.JOptionPane
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import java.util.HashMap
import dk.sdu.mmmi.mdsd.math.External
import dk.sdu.mmmi.mdsd.math.ExternalUse

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MathGenerator extends AbstractGenerator {
	
	static Map<String, String> variables;

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val math = resource.allContents.filter(MathExp).next
		generateMathFile(math, "math_expression", fsa)
	}
		
	def generateMathFile(MathExp math, String pkgName, IFileSystemAccess2 fsa) {
		fsa.generateFile(pkgName + "/" + math.name + ".java", math.generateJavaClass(pkgName))
	}
	
	def generateJavaClass (MathExp math, String pkgName) '''
	package «pkgName»;
	
	import java.util.*;
		
	public class «math.name» {
		«FOR a:math.variables SEPARATOR "\n"»public int «a.name»;«ENDFOR»
		«IF math.externals.size > 0»					
		private External external;
		
		public «math.name»(External external){
			this.external = external;
		}
		
		public interface External{
			«FOR external : math.externals»
			 	«external.computeExpression»;
			«ENDFOR»
		}
		«ENDIF»
		«math.genCompute»

		
	}
	'''
	
	def String genCompute(MathExp exp) {
		exp.compute()
		
		return '''
		public void compute() {
			«FOR v : exp.variables»
			«v.name» = «v.computeExpression»;
			«ENDFOR»
		}
		'''
	}
	
	def static compute(MathExp math) {
		variables = new HashMap()
		for(varBinding: math.variables)
			varBinding.computeExpression()
		variables
	}
	
	def static dispatch String computeExpression(VarBinding binding) {
		variables.put(binding.name, binding.expression.computeExpression())
		return variables.get(binding.name)
	}

	def static dispatch String computeExpression(MathNumber exp) {
		exp.value.toString
	}
	def static dispatch String computeExpression(Plus exp) {
		exp.left.computeExpression + ' + ' + exp.right.computeExpression
	}

	def static dispatch String computeExpression(Minus exp) {
		exp.left.computeExpression + ' - ' + exp.right.computeExpression
	}
	
	def static dispatch String computeExpression(Mult exp) {
		exp.left.computeExpression + ' * ' + exp.right.computeExpression
	}
	
	def static dispatch String computeExpression(Div exp) {
		exp.left.computeExpression + ' / ' + exp.right.computeExpression
	}

	def static dispatch String computeExpression(LetBinding exp) {
		exp.body.computeExpression
	}

	def static dispatch String computeExpression(VariableUse exp) {
		"(" + exp.ref.computeBinding + ")"
	}
	
	def static dispatch String computeExpression(Parenthesis exp){
		'(' + exp.exp.computeExpression + ')'
	}

	def static dispatch String computeBinding(VarBinding binding){	
		binding.name
	}

	def static dispatch String computeBinding(LetBinding binding){
		binding.binding.computeExpression
	}	
	
	def static dispatch String computeExpression(External exp){
		"public int " + exp.name +  '''(«IF exp.parameters.size == 1»int n«ENDIF»«IF exp.parameters.size == 2»int n, int m«ENDIF»)''' 
	}
	
	def static dispatch String computeExpression(ExternalUse exp){
		'''this.external.'''+ exp.ref.name + '''(«FOR x : exp.args SEPARATOR ', '» «x.computeExpression» «ENDFOR»)''' 
	}
		
	def void displayPanel(Map<String, Integer> result) {
		var resultString = ""
		for (entry : result.entrySet()) {
         	resultString += "var " + entry.getKey() + " = " + entry.getValue() + "\n"
        }
		
		JOptionPane.showMessageDialog(null, resultString ,"Math Language", JOptionPane.INFORMATION_MESSAGE)
	}
	
}
