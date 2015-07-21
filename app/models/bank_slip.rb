class BankSlip
  include ActiveModel::Model
  
  attr_accessor :product_identifier, :segment, :real_value_identifier, :check_digit, :value, :free_field, :cnpj
  attr_accessor :barcode, :deadline, :cpf, :unique_code, :barcode_no_digit, :barcode_with_digit, :barcode_with_all_digit
  attr_accessor :block_one, :block_two, :block_three, :block_four
  attr_accessor :block_digit_one, :block_digit_two, :block_digit_three, :block_digit_four
 
  validates_presence_of :value, :deadline 
  validates :value, numericality: true
  ## Identificador CNPJ da Codhab 0344 :cnpj

  CNPJ_CODHAB = "0344"
  ## Identificação do produto :product é igual 8 para identificar que é uma 'arrecadação'
  
  PRODUCT_IDENTIFIER = 8
  ## Identificação do (:segment) é baseada em:
  #   => 1  Prefeituras
  #   => 2  Saneamento
  #   => 3  Energia Elétrica e Gás
  #   => 4  Telecomunicações
  #   => 5  Órgãos Governamentais
  #   => 6  Carnes e Assemelhados ou demais Empreas / Órgãos que serão identificados através de CNPJ
  #   => 7  Multas de trânsito
  #   => 8  Uso exclusio bancário
  #   
  #   com isso a Codhab é uma empresa governamental logo utiliza (:segment) = 5
  #
  
  SEGMENT = 5
  ## Identificador de valor efetivo ou de referência (:real_value_identifier) é baseado em:
  #   
  #   => 6 valor a ser cobrado efetivamento em reais 
  #     => com dígito verificador calculado pelo módulo 10 na quarta posição do :barcode e valor com 11 posições - versão 2 e posterior - sem qualquer alteração)
  #   
  #   => 7 quantidade em moeda
  #     => zeros - somente na impossibilidade de utilizar o valor
  #     => valor - a ser reajustado por um índice
  #     => com dígito verificador calculado pelo módulo 10 na quarta posição do Código de Barras e valor com 11 posições (versão 2 e posteriores).
  #
  #   => 8 valor a ser cobrado efetivamente em reais 
  #     => com dígito verificador calculado pelo módulo 11 na quarta posição do Código de Barras e valor com 11 posições (versão 2 e posteriores) sem qualquer alteração.
  #
  #   => 9 quantidade de moeda 
  #     =>  zeros - somente na impossibilidade de utilizar o valor;
  #     =>  valor - a ser reajustado por um índice
  #     =>  com dígito verificador calculado pelo módulo 11 na quarta posição do Código de Barras e valor com 11 posições (versão 2 e posteriores).
  #
  
  REAL_VALUE_IDENTIFIER = 6
  ## Dígito verficador (:check_digit)
  #   => Dígito de auto conferência dos dados contidos no Código de Barras.   
      
  ## Valor efetivo ou Valor Referência (:value)
  #   => Se o campo “03 – Código de Moeda” indicar valor efetivo, este campo deverá conter o valor a ser cobrado.
  #   => Se o campo “03 - Código de Moeda” indicado valor de referência, neste campo poderá conter uma quantidade de moeda, zeros, ou um valor a ser reajustado por um índice, etc...
  #    
   
  ## Identificação de Empresa/Órgão (:company_identifier)
  #   =>  O campo identificação da Empresa/Órgão terá uma codificação especial para cada segmento.
  #       Será um código de quatro posições atribuído e controlado pela Febraban, ou as primeiras oito posições do cadastro geral de contribuintes do Ministério da Fazenda.
  #       É através desta informação que o banco identificará a quem repassar as informações e o crédito.
  #       Se for utilizado o CNPJ para identificar a Empresa/Órgão, haverá uma redução no seu campo livre que passará a conter 21 posições.
  #       No caso de utilização do Segmento 9, este campo deverá conter o código de compensação do mesmo, com quatro dígitos.
  #       Cada banco definirá a forma de identificação da empresa a partir da 20a posição.
  ## Campo livre (:first_free_field && :second_free_field)
  #   => Este campo é de uso exclusivo da Empresa/Órgão e será devolvido inalterado.
  #   => Se existir data de vencimento no campo livre, ela deverá vir em primeiro lugar e em formato AAAAMMDD.
  # :value
  # :deadline 
  # :unique_code(id)
  #ver com jesus
  def initialize(args)
    
    self.product_identifier     = PRODUCT_IDENTIFIER
    self.segment                = SEGMENT
    self.real_value_identifier  = REAL_VALUE_IDENTIFIER
    self.value        = format_value args[:value]
    self.deadline     = format_deadline args[:deadline]
    
    self.unique_code  = args[:unique_code]
    
    self.cnpj         = CNPJ_CODHAB
    self.free_field   = format_free_field
    self.barcode_no_digit       = format_barcode_no_digit
    self.check_digit            = format_digit
    self.barcode_with_digit     = format_barcode_digit
    self.barcode_with_all_digit = format_barcode_digits
  end

  
  private
  ## formatação e calculos de digitos para o código de barras
  ## formatação do digital geral, na posíção 3 do código de barras (iniciando em 0)
  def format_digit
    calc self.barcode_no_digit
  end
  # formatação de codigo de barras com o digito geral na posição de 3
  def format_barcode_digit
    before_digit  = self.barcode_no_digit[0..2]
    after_digit   = self.barcode_no_digit[3..44]
       
    "#{before_digit}#{self.check_digit}#{after_digit}"
  end
  # formtação de código de barras com todos os digitos ao final dos blocos
  # mantendo o codigo geral na posição 3
  def format_barcode_digits
    #separa os blocos
    self.block_one   = self.barcode_with_digit[0..10]  
    self.block_two   = self.barcode_with_digit[11..21] 
    self.block_three = self.barcode_with_digit[22..32]  
    self.block_four  = self.barcode_with_digit[33..44] 
    #calcula os identificadores
    self.block_digit_one   = calc block_one
    self.block_digit_two   = calc block_two
    self.block_digit_three = calc block_three
    self.block_digit_four  = calc block_four
    #retorna montagem
    "#{block_one}#{block_digit_one}#{block_two}#{block_digit_two}#{block_three}#{block_digit_three}#{block_four}#{block_digit_four}"
  end
  
  def format_barcode_no_digit
    "#{self.product_identifier}#{self.segment}#{self.real_value_identifier}#{self.value}#{self.cnpj}#{self.free_field}"
  end
  def format_value(value)
    return nil if value.class != Integer || value.nil?
   
    value = value.to_s.gsub('.','')
    '%011d' % value.to_i
  end
  def format_deadline(date)
    DateTime.parse(date).strftime('%Y%m%d') rescue false
  end
  def format_free_field
    "#{self.deadline}#{('%017d' % self.unique_code.to_i)}" 
  end
  protected
  ## Calculo de módulo dos Digitios Geral do convênio
  #  O manual do BACEN cita para ser utlizado MODULO 10 ou  MODULO 11 para realizar esse calculo
  #  o mesmo aplica uma formula algoritmica para realiza isso
  #  curiosamente o calculo abaixa não está utilizando nenhuma dos dois calculos e nem seguindo o manual
  #  esse calculo é baseado no calculo do antigo gerador de boleto escrito em C#
  #  a classe de referência do C# se encontra na documentação da API
  #  isso deve ser refatorado para a documentação oficial, se não for possível verificar por que diabos é assim.
  # 1. pega cada caractere do :barcode 
  # 2. inicia um multiplicador :mutiplier em 1 e soma +1 a cada interação
  # 3. divide :multiplier por 2 SE houver resto, o caracter corrente :char é multiplicado por 2 (o mesmo deve ser transformado em Integer)
  #    o resultado deve ser concatenado (transformado novamente para String) dentro de :total_str
  # 4. não havendo resto na divisão (a mesma dando 0), o :char é concatenado :total_str sem modificações
  # 5. a cada interação, deve-se pegar cada novo :char e transforma-lo em Integer e realizar a soma com :total_int, logo a cada interação 
  #    :total_int soma seu valor com o novo char, ao final ele terá a soma de todos os :char
  # 6. após as interações do looping :total_str estará completa e :total_int terá o valor final
  # 7. :identifier, o identificado de retorno divide :total_int por 10, se houver resto, ele define que o identificador é igual a 10 menos o resto da divisão 
  # 8. se não houver resto o :indentifier é igual a 0
  ## Esse calculo é usado em todos os numeros identificados do convenio, isso quer dizer, em todos os 4 blocos de numeros
  
  def calc(barcode)
    total_int   = 0
    multiplier  = 1
    ## dois loopings da pra refatorar mais
    barcode.each_char do |char|
      total_int   += ((multiplier % 2) != 0) ? sum_integer(char.to_i * 2) : char.to_i
      multiplier  +=  1
    end
    
    ## TODO
    # aqui da pra melhorar, total_int está sendo dividido duas vezes
    identifier = ((total_int % 10) != 0) ? 10 - (total_int % 10) : 0
  end
  def sum_integer(num)
    #calculo de resultados acima de 9 onde há dois caracters a serem somados entre si
    value = 0
    num.to_s.each_char { |char| value += char.to_i }
    value
  end
end

