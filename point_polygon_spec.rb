require 'rubygems'
require 'spec'

# TODOS:
# arrumar a lógica do Polygon.contains?
# refatorar:
# => extrair as classes em vários arquivos
# => renomear as variáveis do método corta
# => tudo em ingles
# => acessar x e y do ponto por point.x e point.y
# => precisamos de duas classes pra segmento e semireta?


class SegmentoReta
	def initialize(point1, point2)
		@point1 = point1.collect{|i| i.to_f }	
		@point2 = point2.collect{|i| i.to_f }	
	end
	
	def point1
		@point1
	end
	
	def point2
		@point2
	end
end

class SemiReta

	def initialize(point1, point2)
		@point1 = point1.collect{|i| i.to_f }		
		@point2 = point2.collect{|i| i.to_f }			
	end

	def corta(segmento)
		# c.a. da Reta 1 - Semi Reta
		m1 = (@point1[1] - @point2[1])/(@point1[0] - @point2[0])
		# c.a. da Reta 2 - segmento de reta		
		m2 = (segmento.point1[1] - segmento.point2[1])/(segmento.point1[0] - segmento.point2[0])
		
		h1 = @point1[1] - m1 * @point1[0]
		h2 = segmento.point1[1] - m2 * segmento.point1[0]
	
		x = (h2 - h1) / (m1 - m2)
		y = m1 * x + h1
		
		x >= segmento.point1[0] and x <= segmento.point2[0]
	end	
end

class Polygon
	
	def initialize(points)
		@points = points
	end
	
	def contain?(point)
		segmentoReta1 = SegmentoReta.new(@points[0], @points[1])
		segmentoReta2 = SegmentoReta.new(@points[1], @points[2])
		segmentoReta3 = SegmentoReta.new(@points[2], @points[0])
		 
		semiRetaTeste = SemiReta.new(point, [point[0]+1, point[1]+1])
		
		#TODO mudar: numero impar de cortes
		if semiRetaTeste.corta(segmentoReta1) or semiRetaTeste.corta(segmentoReta2) or semiRetaTeste.corta(segmentoReta3) 
			true
		else
			false
		end
	end
	
end

describe Polygon do
	
	it "should find an external point" do
		
	 	polygon = Polygon.new [[2,2] , [3,3], [4,1]]
		point = [1,1]
		
		polygon.should_not be_contain point
		
	end
	
	it "should find an internal point" do
			polygon = Polygon.new [[2,2] , [3,3], [4,1]]
			point = [3,2]

			polygon.should be_contain point
	end
	
end

describe SemiReta do
	
	it "should detect a cutting segment" do
		
		semireta = SemiReta.new([0,0], [1,1])
		segmento = SegmentoReta.new([0,1], [1,0])
		
		semireta.corta(segmento).should == true
		
	end
	
end