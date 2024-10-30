<?php
declare(strict_types=1);

use Migrations\AbstractMigration;

class CreateClientes extends AbstractMigration
{
    /**
     * Change Method.
     *
     * More information on this method is available here:
     * https://book.cakephp.org/phinx/0/en/migrations.html#the-change-method
     * @return void
     */
    public function change(): void
    {
        $table = $this->table('clientes');
        $table->addColumn('nome', 'string', [
            'default' => null,
            'limit'   => 120,
            'null'    => false,
        ]);
        $table->addColumn('email', 'string', [
            'default' => null,
            'limit'   => 200,
            'null'    => false,
        ]);
        $table->addColumn('telefone', 'string', [
            'default' => null,
            'limit'   => 15,
            'null'    => true,
        ]);
        $table->addColumn('excluido', 'boolean', [
            'default' => false,
            'null'    => false,
        ]);
        $table->addColumn('created', 'timestamp', [
            'default' => 'CURRENT_TIMESTAMP',
        ]);
        $table->addColumn('modified', 'timestamp', [
            'default' => 'CURRENT_TIMESTAMP',
            'update'  => 'CURRENT_TIMESTAMP'
        ]);
        $table->create();
    }
}
